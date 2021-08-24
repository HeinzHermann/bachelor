--[[

Creator: Marvin Glaser
Purpose: Parse Vetrex information from .ugx files to correlate vetex position and vertex subset

]]

--[[ rewrite name list of grid subsets to search condition ]] 
function prep_names(name_list)
	local string_list={}
	if next(name_list)==nil then
		print("Error, empty name list provided")
		return
	end
	for i=1, #name_list do
		local string="name=".."\""..name_list[i].."\""
		print(string) -- test print
		string_list[i]=string
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
function get_association(file, comment)

	for string in file:lines() do
		local comment_line = (string.find(line, comment)==1)
		if not(comment_line) then 
		--	print()
		end

	end
end


--[[ parse .ugx file for coodinates and vertex-subset association ]]
-- work in progress
function parse_data(path, filename, filetype, comment, name_list)
	local data={}
	local target_strings=prep_names(name_list)
	local parse=false

	-- open file and verify success
	file = io.open(path.."/"..filename.."."..filetype, "r")
	if file==nil then
		print("Error, no .ugx file to parse")
		return nil
	end

	positions = get_positions(file, comment)	
	for i=1, #positions do
		print("["..positions[i][1]..","..positions[i][2]..","..positions[i][3].."]" )
	end

	--get_association(file, comment, target_strings)
	
	file:close()

	-- testing
	--print(path.."/"..filename.."."..filetype)


end


function testing()
	-- testing grounds
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


	print("=================")
	print(string.match("0</vertex>", "-?%d+[^\"<]?%.?%d*"))

end



-- main
local test_list={"test", "drive", "names"}
local path = "../geometry"
local file = "DE-HE"
local ftype = "ugx"
local comment = "#"

parse_data(path, file, ftype, comment, test_list)


print("===============================================")
print("test results:")
--testing()

