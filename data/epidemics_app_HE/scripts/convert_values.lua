--[[
	Authors: Devansh Rastogi & Tristan Schneidemann
	Modified: Marvin Glaser
]]


--[[
reads data from files, creates timestamp table and data table
Output format:
timedata_table, simdata_table

time table structure = {t1, t2, t3...}
data table structure = table, contains table for every file, contains table for every subset in file
	{
		{
			{row1_density,row1_index}{row2_density,row2_index}...
		}
		{
			{row1_density,row1_index}{row2_density,row2_index}...
		}
		...
	}
]]
function get_densities(path, filename,filetype,comment,startindex)
	local timevals={}
	local keep_iterating=true
	local data={}
	local iter=1

	-- iterate through data files until none are left
	while keep_iterating do
		file=io.open(path..filename.."_"..tostring(startindex+iter-1)..filetype)
		if file==nil then
			-- all files processed
			keep_iterating=false
		else
			local row=1
			local omit_time=false
			data[iter]={}
			for line in file:lines() do
				-- ignore comment lines
				if string.match(line,comment) then
				else
					data[iter][row]={}
					-- record time value for every new file
					if omit_time==false then
						local temp=line:match("[^,]+")
						timevals[iter]=tonumber(temp)
						omit_time=true
					end
					local omit_column=true
					local counter=1
					for number in line:gmatch("[^,]+") do
						-- omit_comlum --> ignore first match (time)
						if omit_column==false then
							data[iter][row][counter]=tonumber(number)
							counter=counter+1
						else
							omit_column=false
						end
					end
					row=row+1
				end
			end
			iter=iter+1
		end
	end
	if (data==nil) then
		error("Error in get_data: Data is nil")
	end

	return timevals,data
end


--[[
Parses the data from all .csvs into a single file. The time column will be omitted
(assumed to be first column in each file), so that only the "data" will be saved
Output format
timedata_table, simdata_table

time_table structure = {t1, t2, t3...}
simdata_table structure = table, containing table for every file, containing table for every vertex, containing data
{
	{								--> file1
		{vert1_posx,vert1_posy,s, e, i,r,d}			--> vertex1
		{vert2_posx,vert2_posy,s,e,i,r,d}			--> vertex2
		...		
	}
	{								--> file2
		{ver1...}						--> vertex1
		...
	}
	...
}
]]
function get_simdata(path, filename,filetype,comment,startindex)
	local timevals={}
	local keep_iterating=true
	
	-- contains the data of all files
	local data={} 

	-- number of the document from which is read
	local iter=1 

	while keep_iterating do
		file=io.open(path..filename.."_"..tostring(startindex+iter-1)..filetype)
		if file==nil then
			keep_iterating=false
		else
			-- row represents a single vertex
			local row=0 

			local omit_time=false
			data[iter]={}
			local linenumber= 0
			local omit_line = false
			local counter=1
			for line in file:lines() do 
				-- if line is not a comment
				if string.match(line,comment) then 
				else				 
					-- if document row multiple of 5 (read SEIRD data as a package)
					if linenumber%5==0 then 
						counter=1
						row=row+1
						data[iter][row]={}

						-- write time of line into timevals[iter]
						if omit_time==false then
							local temp=line:match("[^,]+")
							timevals[iter]=tonumber(temp)
							omit_time=true
						end
						local omit_column=true
					
						-- write posx, posy, S into data
						for number in line:gmatch("[^,]+") do

							-- omit_column --> ignore first match (time), then process rest
							if omit_column==false then
								data[iter][row][counter]=tonumber(number)
								counter=counter+1
							else
								omit_column=false
							end
						 end 
						 
					-- ignore time, posx, posy from following rows and only add EIRD values
					else
						local omits=3
						for number in line:gmatch("[^,]+") do

							-- ignore time, xpos, ypos, then insert value
							if omits ~= 0 then
								omits= omits-1
							else
								data[iter][row][counter]=tonumber(number)
								counter=counter+1
							end
						 end 
					end
				linenumber = linenumber+1
				end --end if (check for comment line)
			end -- for line end (end of document)
			iter=iter+1 -- next document
		end --end if file==nil
	end --end while keep_iterating
	if (data==nil) then
		print("Error in get_data: Data is nil")
	end

	return timevals,data
end

--Prints 2d lua table that can be indexed like an array
function print_data(data)
	--print(#data)
	result=""
	for i= 1, #data do
		--print(#data[1])
		for j= 1, #data[1] do
			result=result..data[i][j].."\t"
		end
		result=result.."\n"
	end
	print(result)
end

--[[
Write content of data into set of files (filenames) at given paths (paths)
--]]
function write_data(paths,filenames,comment,timesteps,data,names)
	
	-- check if every path has a correct filename and the other way around
	if (#paths ~= #filenames) then
		error("number of paths and number of filenames is not equal", 2)	
	end

	-- for every class create a file
	for class=1, #data do
		file = io.open(paths[class]..filenames[class], "w")


		-- sanity check for array dimensions, assumes that columns per file are identical in data
		if (#names ~= #data[class][1]) then
			error("number of column names different from number of columns in class number "..class, 2)
		end
		-- check for correct number of timesteps
		if (#data[class] ~= #timesteps) then
			error("timesteps in class number "..class.."are not equal to expected timesteps", 2)
		end


		-- insert the column names in the first row of new file
		result = comment.."time"
		for column=1, #names do
			result = result..","..names[column]
		end
		result = result.."\n"

		-- for every timestep in the class
		for time=1, #data[class] do
			-- write the current timestep
			result = result..timesteps[time]

			-- and write every population count into the following rows
			for subset=1, #data[class][time] do
				result = result..","..data[class][time][subset]		
			end
			result = result.."\n"

		end
		file:write(result)
		file:close()
	end
end


--[[
associates simdata with ist sepecific subset data
association is realized as a table
output = table of tables, containing vertex numbers of a subset
output = {
		{			-- first subset
		1, 3, 4, 8, 9, ...	-- vertex index associated with first subset
		}
		,{			-- second subset
		...			-- vertex index associated with second subset
		}
		...
	}
]]
function associate_pos(simdata, associations)
	local vertex_subset_ass = {}	
	local vertex_count = #simdata
	local associations_count = (#associations - 1) -- first value is number of subsets
	
	-- if nubmer of vertices differ between simdata and associations
	if not(vertex_count == associations_count) then
		error("unequal number of vertices in simdata and associaions table")
	end

	-- for every vertex
	local no_match = true
	for vertex=1, vertex_count do
		no_match = true
		local counter = 1
		-- look trough all associations (check=2 --> first value is number of subsets)
		for check=2, #associations do
			-- until you find a matching pair of x and y  positions
			-- note: round to second digit and compare values
			--if ((math.floor(simdata[vertex][1]*10 + 0.5)/10) == (math.floor(associations[check][1]*10 + 0.5)/10))
			--   and ((math.floor(simdata[vertex][2]*10 + 0.5)/10) == (math.floor(associations[check][2]*10 + 0.5)/10)) then
			if (math.abs(simdata[vertex][1] - associations[check][1]) <= 0.1
			   and (math.abs(simdata[vertex][2] - associations[check][2]) <= 0.1)) then

			   	-- if no entry exists for this subset yet, create one
				if vertex_subset_ass[associations[check][4]] == nil then
					vertex_subset_ass[associations[check][4]] = {}
				end

				-- write vertex index into subset table
				table.insert(vertex_subset_ass[associations[check][4]], vertex)
				no_match = false
				break
			end
		end
		-- if association failed
		if no_match then
			print("error at vertex "..vertex)
			print("pos x simdata="..simdata[vertex][1])
			print("pos x simdata_round="..(math.floor(simdata[vertex][1]*10 + 0.5)/10))
			print("pos y simdata="..simdata[vertex][2])
			print("pos y simdata_round="..(math.floor(simdata[vertex][2]*10 + 0.5)/10))
			error("Error, simdata vertex could not be associated with a subset")
		end
	end
	-- return ass
	return vertex_subset_ass 
end


--[[
Tailors data from timesteps, simdata and densities together
Output format
output = table containing a table for each column(class), containing a table for each file, containing the population of each subset
{	
	{						--> class1
		{pop_subset1,pop_subset2,...}		--> population file1
		,{pop_subset1,pop_subset2,...}		--> population file2
		,..
	}
	{						--> class2
		{pop_subset1,pop_subset2,...}		--> population file1
		,{pop_subset1,pop_subset2,...}		--> population file2
		,..
	}
}
]]
function tailor_data(timesteps,simdata,densities,area_sizes,association,posx,posy,cols)
	local output={}

	local vertex_subset_ass = associate_pos(simdata[1], association)

	-- for every class (requested entry in cols)
	for col=1, #cols do
		output[col] = {}
		-- calculate for every timestep
		for time=1, timesteps do
			output[col][time]={}
			 -- and every subset
			for subset=1, #vertex_subset_ass do
				local grid_sum = 0
				-- the average population of all gridpoints (in the respective subset)
				for vertex=1, #vertex_subset_ass[subset] do
					grid_sum = grid_sum + simdata[time][vertex][col]
					-- data[i] is data of one simdata file
				end	
				-- average normalized fractionof total population for class and time (sum_vertex/num_vertex)
				output[col][time][subset] = grid_sum / #vertex_subset_ass[subset]
				-- calculate total population = normalized_fraction * area [km^2] * density [1/km^2]
				output[col][time][subset] = output[col][time][subset] * area_sizes[subset] * densities[time][subset][1]
			end	
		end
	end
	return output
end

