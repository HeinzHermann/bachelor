--[[
	Authors: Devansh Rastogi & Tristan Schneidemann
	Modified: Marvin Glaser
]]






--[[
reads data from files, creates timestamp table and data table
Output format:
timedata_table, simdata_table

time table structure = {t1, t2, t3...}
data table structure = table, contains table for every file, contains table for every row in file
{{{row1_density,row1_index}{row2_density,row2_index}...}{{row1_density,row1_index}{row2_density,row2_index}...}...}
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
{{{vert1_posx,vert1_posy,s, e, i,r,d}{vert2_posx,vert2_posy,s,e,i,r,d}...}{{ver1...}...}...}
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

--#timesteps: Array of the timestep  #data:2d array of area data per timestep #name: names of the area variables (e.g. city names) 
function write_data(path,filename,filetype,comment,timesteps,data, names)
	if (#data[1] ~= #names) then
		print("Error in write data: names and data array dimensions are wrong\n")
	end

	result=""
	result=comment.."time"
	for index, name in ipairs(names) do
		result=result.."\t"..name
	end
	result=result.."\n"
	f=io.open(path..filename..filetype,"w")
	for k=1,#timesteps do

		result=result..timesteps[k]
	
		for j=1,#data[1] do
			result=result.."\t"..data[k][j]
		end
		result=result.."\n"

	end
	f:write(result)
	f:close()
end

----------- CITIES ---------------

--FRA
function Frankfurt(data_at_time_t,col,posx, posy,density_at_time_t)
	local radius=8.89 
	local x=-126.971
	local y=-258.315
	local index=-1
	local values={}
	local iter=1

	for j=1, #data_at_time_t do
		if ((x-data_at_time_t[j][posx])*(x-data_at_time_t[j][posx])+(y-data_at_time_t[j][posy])*(y-data_at_time_t[j][posy]))<=(radius*radius) then
			index=j
			values[iter]=data_at_time_t[j][col]
			iter=iter+1
		end
	end

	local mean=0
	for i=1,#values do
		mean=mean+values[i]
	end
	if #values==0 then
		print("Error: One of the error functions has positional coordinates that cannot be found in the data\n")
		os.exit()
	end
	mean=mean/(#values)
	densityIndexFFM=17 --row index of Frankfurt in the density table. Temporary values, probably different in your sim. Index starts at 1
	return mean*3.14*radius*radius*density_at_time_t[densityIndexFFM][1]
end

--WIES
function Wiesbaden(data_at_time_t,col,posx, posy,density_at_time_t)
	--local radius=300 --testing
	local radius=8.05
	local x=-166
	local y=-240
	local index=-1
	local values={}
	local iter=1

	for j=1, #data_at_time_t do
		if ((x-data_at_time_t[j][posx])*(x-data_at_time_t[j][posx])+(y-data_at_time_t[j][posy])*(y-data_at_time_t[j][posy]))<=(radius*radius) then
			index=j
			values[iter]=data_at_time_t[j][col]
			iter=iter+1
		end
	end

	local mean=0
	for i=1,#values do
		mean=mean+values[i]
	end
	if #values==0 then
		print("Error: One of the error functions has positional coordinates that cannot be found in the data\n")
		os.exit()
	end
	mean=mean/(#values)
	densityIndexWIE=18 
	return mean*3.14*radius*radius*density_at_time_t[densityIndexWIE][1]
end

--STU
function Stuttgart(data_at_time_t,col,posx, posy,density_at_time_t)
	--local radius=300 --testing
	local radius=8.12
	local x=-78.76 
	local y=-406.635
	local index=-1
	local values={}
	local iter=1

	for j=1, #data_at_time_t do
		if ((x-data_at_time_t[j][posx])*(x-data_at_time_t[j][posx])+(y-data_at_time_t[j][posy])*(y-data_at_time_t[j][posy]))<=(radius*radius) then
			index=j
			values[iter]=data_at_time_t[j][col]
			iter=iter+1
		end
	end

	local mean=0
	for i=1,#values do
		mean=mean+values[i]
	end
	if #values==0 then
		print("Error: One of the error functions has positional coordinates that cannot be found in the data\n")
		os.exit()
	end
	mean=mean/(#values)
	densityIndexSTU=19 
	return mean*3.14*radius*radius*density_at_time_t[densityIndexSTU][1]
end

--HANN
function Hannover(data_at_time_t,col,posx, posy,density_at_time_t)
	local radius=8.061
	local x=-41.784
	local y=13.7585
	local index=-1
	local values={}
	local iter=1

	for j=1, #data_at_time_t do
		if ((x-data_at_time_t[j][posx])*(x-data_at_time_t[j][posx])+(y-data_at_time_t[j][posy])*(y-data_at_time_t[j][posy]))<=(radius*radius) then
			index=j
			values[iter]=data_at_time_t[j][col]
			iter=iter+1
		end
	end

	local mean=0
	for i=1,#values do
		mean=mean+values[i]
	end
	if #values==0 then
		print("Error: One of the error functions has positional coordinates that cannot be found in the data\n")
		os.exit()
	end
	mean=mean/(#values)
	densityIndexHANN=20
	return mean*3.14*radius*radius*density_at_time_t[densityIndexHANN][1]
end

--MUN
function Munich(data_at_time_t,col,posx, posy,density_at_time_t)
	--local radius=300 --testing
	local radius=9.94
	local x=78.84
	local y=-480.961
	local index=-1
	local values={}
	local iter=1

	for j=1, #data_at_time_t do
		if ((x-data_at_time_t[j][posx])*(x-data_at_time_t[j][posx])+(y-data_at_time_t[j][posy])*(y-data_at_time_t[j][posy]))<=(radius*radius) then
			index=j
			values[iter]=data_at_time_t[j][col]
			iter=iter+1
		end
	end

	local mean=0
	for i=1,#values do
		mean=mean+values[i]
	end
	if #values==0 then
		print("Error: One of the error functions has positional coordinates that cannot be found in the data\n")
		os.exit()
	end
	mean=mean/(#values)
	densityIndexMUN=21
	return mean*3.14*radius*radius*density_at_time_t[densityIndexMUN][1]
end

--HEINS
function Heinsberg(data_at_time_t,col,posx, posy,density_at_time_t)
	--local radius=300 --testing
	local radius=5.42
	local x=-338.146 
	local y=-151.782
	local index=-1
	local values={}
	local iter=1

	for j=1, #data_at_time_t do
		if ((x-data_at_time_t[j][posx])*(x-data_at_time_t[j][posx])+(y-data_at_time_t[j][posy])*(y-data_at_time_t[j][posy]))<=(radius*radius) then
			index=j
			values[iter]=data_at_time_t[j][col]
			iter=iter+1
		end
	end

	local mean=0
	for i=1,#values do
		mean=mean+values[i]
	end
	if #values==0 then
		print("Error: One of the error functions has positional coordinates that cannot be found in the data\n")
		os.exit()
	end
	mean=mean/(#values)
	densityIndexHEINS=22
	return mean*3.14*radius*radius*density_at_time_t[densityIndexHEINS][1]
end

--BE
function Berlin(data_at_time_t,col,posx, posy,density_at_time_t)
	--local radius=300 --testing
	local radius=16.84
	local x=209.037
	local y=15.913
	local index=-1
	local values={}
	local iter=1

	for j=1, #data_at_time_t do
		if ((x-data_at_time_t[j][posx])*(x-data_at_time_t[j][posx])+(y-data_at_time_t[j][posy])*(y-data_at_time_t[j][posy]))<=(radius*radius) then
			index=j
			values[iter]=data_at_time_t[j][col]
			iter=iter+1
		end
	end

	local mean=0
	for i=1,#values do
		mean=mean+values[i]
	end
	if #values==0 then
		print("Error: One of the error functions has positional coordinates that cannot be found in the data\n")
		os.exit()
	end
	mean=mean/(#values)
	densityIndexBE=11
	return mean*3.14*radius*radius*density_at_time_t[densityIndexBE][1]
end

----------- CITIES end ---------------

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
	for vertex=1, vertex_count do
		local search_association = true
		local counter = 1
		-- look trough all associations (check=2 --> first value is number of subsets)
		for check=2, #associations do
			-- until you find a matching pair of x and y  positions
			if simdata[vertex][1] == associations[check][1] and simdata[vertex][2] == associations[check][2] then
				-- write vertex index into subset table
				table.insert(vertex_subset_ass[associations[check][4]], vertex)
			end
		end
		-- if association failed
		if vertex_subset_ass[vertex] == nil then
			error("Error, simdata (pos x="..simdata[vertex][1]..", y="..simdata[vertex][1]
					..") could not be associated with a subset")
		end
	end
	-- return ass
	return vertex_subset_ass 
end


--#timesteps: timesteps of the simulation #data: contains sim data only #col which column of the data table to focus on (e.g. ngesteckte) #posx index of x position in the data array (without time column) #areafunction: table containing functions of area #densities: contains densities at various times
--[[ OLD CODE
function tailor_data(timesteps,simdata,col,posx,posy,areafunctions,densities)
	nSteps=#timesteps
	nVariables=#areafunctions
	output={}

	-- for evey timestesp do
	for i=1, nSteps do
		output[i]={}
		for j=1, nVariables do
			-- data[i] is data of one simdata file
			local value=areafunctions[j](simdata[i],col,posx,posy,densities[i]) -- using denstiy for time step 0 as others wont load 
			output[i][j]=value
		end	
	end
	return output
end
]]

--[[
Tailors data from timesteps, simdata and densities together
Output format
output =
{{}}

]]
-- Get areas of subsets somehow, needed to calculate
-- WORK IN PROGRESS
function tailor_data_new(timesteps,simdata,densities,association,posx,posy,cols)
	local output={}

	local vertex_subset_ass = associate_pos(simdata[1], association)

	-- for every class (requested entry in cols)
	for col=1, #cols do
		-- calculate for every timestep
		for time=1, timesteps do
			output[time]={}
			 -- and every subset
			for subset=1, #vertex_subset_ass do
				local grid_sum = 0
				-- the average population of all gridpoints (in the respective subset)
				for vertex=1, #vertex_subset_ass[subset] do
					grid_sum = grid_sum + simdata[time][vertex][col]
					-- data[i] is data of one simdata file
				end	
			-- average fraction of total population for class and time (sum_vertex/num_vertex)
			output[time][subset] = grid_sum / #vertex_subset_ass[j]
			end	
		end
	end
	return output
end

-- read data from documents
local timesteps,simdata=get_simdata("./","output/simdata_step",".csv","#",0)
local temp,densities=get_densities("./","output/density_step",".csv","T",0)


areas={}
areas[1]=Hannover
areas[2]=Heinsberg
areas[3]=Frankfurt
areas[4]=Wiesbaden
areas[5]=Stuttgart
areas[6]=Munich
areas[7]=Berlin



data_e=tailor_data(#timesteps,simdata,densities,1,2,4)
--data_v=tailor_data(timesteps,simdata,7,1,2,areas,densities)


--[[ does not appear to be in use

print("Parsed timesteps")
print_timesteps(timesteps)
print("Parsed data")
print_data(data[2]) --prints data at time 0 (don't forget: Lua indices by convention start at 1)
print("Parsed densities")
print_data(densities[1]) --prints density at time 0 (don't forget: Lua indices start at 1)

]]

print("Writing integrated Data to file..")
write_data("./","output_v",".csv","#",timesteps,data_v,{"Hannover","Heinsberg","Frankfurt","Wiesbaden", "Stuttgart","Munich","Berlin"})

write_data("./","output_a",".csv","#",timesteps,data_a,{"Hannover","Heinsberg","Frankfurt","Wiesbaden", "Stuttgart","Munich","Berlin"})

print("Data has been written to file") 
