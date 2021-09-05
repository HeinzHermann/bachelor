--[[
Author: Marvin Glaser
Purpose: Parse Vetrex information from .ugx files to correlate vetex position and vertex subset
]]


--[[ Read config file and extract information ]]
function read_config(path, filename, comment)
	
	file = io.open(path.."/"..filename, "r")
	-- check for false input
	if file==nil then
		error("Error, invalid path or filename", 2)
	end


	local parameters = {}

	-- initiallize subset names
	parameters[4] = {}
	local subset_reading = false

	-- todo: path, name, comment, f
	for line in file:lines() do
		local comment_line = (string.find(line, comment)==1)
		if not(comment_line) then 
			if string.find(line, "path=") then
				parameters[1] = string.gsub(line, "path=", "", 1)
			elseif string.find(line, "filename=") then
				parameters[2] = string.gsub(line, "filename=", "", 1)
			elseif string.find(line, "comment=") then
				parameters[3] = string.gsub(line, "comment=", "", 1)
			elseif string.find(line, "!subset_names") then
				subset_reading = true
			elseif string.find(line, "!subset_end") then
				subset_reading = false
			-- if non of the above AND subset reading
			elseif subset_reading then
				table.insert(parameters[4], line)
			end
		end
	end
	file:close()

	if parameters[1]==nil or parameters[2]==nil or parameters[3]==nil or next(parameters[4])==nil then
		error("Error, one or more necessary parameters could not be parsed from config file")
	end
	--print("finished read_config")
	return parameters
end


--[[ rewrite name list of grid subsets to search condition ]] 
function prep_names(name_list)
	local string_list = {}
	local magic_char = {"(", ")", ".", "%", "+", "-", "*", "?", "[", "^", "$"}

	-- check if name list is empty
	if next(name_list)==nil then
		error("Error, empty name list provided", 2)
	end

	for i=1, #name_list do
		-- reformat name list
		local target = "name=".."\""..name_list[i].."\""
		-- escape magic characters for search
		for j=1, #magic_char do
			target = string.gsub(target, "%"..magic_char[j], "%%"..magic_char[j])
		end
		string_list[i] = target
	end
	--print("finished prep_names")
	return string_list

end

--[[ parse position data from file ]]
function get_positions(file, comment)

	local positions={}
	local target_string = "<vertices coords=\"3\">"
	for line in file:lines() do

		-- check for comment line
		local comment_line = (string.find(line, comment)==1)
		if not(comment_line) then 
	
			-- if target line
			if string.find(line, target_string) then
				local counter = 0
				local axis = 0
				local vertex = 0

				-- fill output table with position data
				-- comment remove target_string; "3" causes difficult problems with matching
				for number in string.gmatch(string.gsub(line, target_string, ""), "-?%d+[^<]?%.?%d*") do

					-- every three loops begin next set of vertex positions
					-- positions = {{x1, y1, z1},{x2, y2, z2}...}
					axis = (counter % 3) + 1
					if axis==1 then
						vertex = vertex+1
						positions[vertex] = {}
					end
					
					positions[vertex][axis] = tonumber(number)
					counter = counter+1
					
				end
				--print("finished get_positions")
				-- stop reading and return, positions already found
				return positions
			end

		end

	end
end


--[[
parse vertex-subset association
output structure: {Subset_count, {x1,y1,z1,Subset_No}, {x2,y2,z2,Subset_No}, ... }
--]]
function get_association(file, comment, targets)

	local associations = {}
	local parse_next = false
	local target_number = 0

	for line in file:lines() do
		local comment_line = (string.find(line, comment)==1)
		if not(comment_line) then 

			-- if line can contain target
			if string.find(line, "<subset name=") then
				-- loop through targets
				for i=1, #targets do
					-- if line contains a target --> parse next
					if string.find(line, targets[i]) then
						parse_next = true
						target_number = i
						break
					end
				end

				
			else
				-- if target found and line contains vertices
				if (parse_next and string.find(line, "<vertices>")) then
					-- if target has been parsed before, return error 
					if associations[target_number] ~= nil then
						print("Error, target subset has been parsed before")
					else
						-- create new association entry
						associations[target_number] = {}
						-- parse all vertex positions
						for vertex_pos in string.gmatch(line, "%d+") do
							-- NOTE: +1 because lua counts from 1, but .ugx file starts counting at 0
							table.insert(associations[target_number], tonumber(vertex_pos)+1) 
						end
						parse_next = false
					end
				end


			end
		end

	end

	-- verify that every target was parsed
	local err = false
	local err_list = {}
	for i=1, #targets do
		if associations[i]==nil then
			err = true
			table.insert(err_list, targets[i])
		end
	end

	if err then
		print("Unparsed targets are:")
		for i=1, #err_list do
			print(err_list[i])
		end
		error("Error, one or more of the targets could not be parsed")
	else
		--print("finished get_association")
		return associations
	end
end


--[[ parse .ugx file for coodinates and vertex-subset association ]]
function parse_ugx(path, filename, comment, name_list)

	local target_strings = prep_names(name_list)

	-- open file and verify success
	file = io.open(path.."/"..filename, "r")
	if file==nil then
		print(path.."/"..filename)
		error("Error, invalid path of filename", 2)
		return nil
	end

	positions = get_positions(file, comment)	
	associations = get_association(file, comment, target_strings)
	
	-- add subset association to position data
	for i=1, #associations do
		for j=1, #associations[i] do
			table.insert(positions[associations[i][j]], i)
		end
	end

	-- insert number of subsets at beginning of output
	table.insert(positions, 1, #associations)


	-- evaluate final output
	--[[
	print("[")
	print(positions[1])
	for i=2, #positions do
		io.write("["..positions[i][2])
		for j=2, #positions[i] do
			io.write(","..positions[i][j])
		end
		print("]")
	end
	print("]")
	]]
	--print("finished parse_ugx")
	return positions
end



--[[ main equivalent, starts process ]]
function run_parser(path_config, filename_config, comment_config)
	
	-- test print
	--[[
	print("calling run_parser with"
		.."\npath_config: "..path_config
		.."\nfilename_config: "..filename_config
		.."\ncomment_config "..comment_config)
	]]
	-- set defaults
	path_config = path_config or "../config" 
	filename_config = filename_config or "geometry_parser.config"
	comment_config = comment_config or "#"

	-- read config file and initiallize ugx parsing
	local parameters = read_config(path_config, filename_config, comment_config)
	local output = parse_ugx(parameters[1], parameters[2], parameters[3], parameters[4])
	--print("finished run_parser")
	return output
end



