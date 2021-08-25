--[[

Creator: Marvin Glaser
Purpose: Parse Vetrex information from .ugx files to correlate vetex position and vertex subset

]]

--[[ rewrite name list of grid subsets to search condition ]] 
function prep_names(name_list)
	local string_list = {}
	local magic_char = {"(", ")", ".", "%", "+", "-", "*", "?", "[", "^", "$"}
	if next(name_list)==nil then
		print("Error, empty name list provided")
		return
	end
	for i=1, #name_list do
		local target = "name=".."\""..name_list[i].."\""
		-- escape magic characters for search
		for j=1, #magic_char do
			target = string.gsub(target, "%"..magic_char[j], "%%"..magic_char[j])
		end
		string_list[i] = target
	end
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
				-- stop reading and return, positions already found
				return positions
			end

		end

	end
end


--[[ parse vertex-subset association ]]
-- work in progress
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
		print("Error, one or more of the targets could not be parsed")
		print("Unparsed targets are:")
		for i=1, #err_list do
			print(err_list[i])
		end
		return nil
	else
	print("returning associations")
	return associations
	end
end


--[[ parse .ugx file for coodinates and vertex-subset association ]]
-- work in progress
function parse_data(path, filename, filetype, comment, name_list)

	local target_strings = prep_names(name_list)

	-- open file and verify success
	file = io.open(path.."/"..filename.."."..filetype, "r")
	if file==nil then
		print("Error, no .ugx file to parse")
		return nil
	end

	positions = get_positions(file, comment)	
	associations = get_association(file, comment, target_strings)
	
	-- add subset association to position data
	for i=1, #associations do
		for j=1, #associations[i] do
			print(associations[i][j])
			table.insert(positions[associations[i][j]], i)
		end
	end

	-- insert number of subsets at beginning of output
	table.insert(positions, 1, #associations)


	--[[
	-- evaluate final output
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
	
	return positions
end


function testing()
	-- testing grounds
	print("===============================================")
	print("Testing:")
	--[[
	print(string.find("xx#test", "#"))
	if next({})==nil then
		print("works as bool")
		else
		print("does not work as bool")
	end

	print(next({}))
	print(next({4,5,6}))
	print(next({4,5,6}, 1))
	print(next({4,5,6}, 2))
	print(next({4,5,6}, 3))

	print(string.match("0</vertex>", "-?%d+[^\"<]?%.?%d*"))

	local table={}
	table[2] = 4
	print(table[2])
	print(table[1])
	table[1] = 3
	print(table[1])
	]]

	print(string.find("<vertices>3", "<vertices>"))

	print("===============================================")
end



-- main
local test_list={"Werra-Meissner-Kreis"
		 ,"Kassel-City"
		 ,"Kassel"
		 ,"Waldeck-Frankenberg"
		 ,"Hersfeld-Rotenburg"
		 ,"Schwalm-Eder-Kreis"
		 ,"Fulda"
		 ,"Marburg-Biedenkopf"
		 ,"Lahn-Dill-Kreis"
		 ,"Limburg-Weilburg"
		 ,"Giessen"
		 ,"Vogelsbergkreis"
		 ,"Main-Kinzig-Kreis"
		 ,"Wetteraukreis"
		 ,"Rheingau-Taunus-Kreis"
		 ,"Hochtaunuskreis"
		 ,"Wiesbaden"
		 ,"Main-Taunus-Kreis"
		 ,"Frankfurt-am-Main"
		 ,"Offenbach-am-Main"
		 ,"Offenbach"
		 ,"Gross-Gerau"
		 ,"Darmstadt"
		 ,"Darmstadt-Dieburg"
		 ,"Odenwaldkreis"
		 ,"Bergstrasse"}
local path = "../geometry"
local file = "DE-HE"
local ftype = "ugx"
local comment = "#"

parse_data(path, file, ftype, comment, test_list)


--testing()

