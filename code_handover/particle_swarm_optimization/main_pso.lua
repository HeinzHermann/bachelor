ug_load_script("ug_util.lua")
local pfile = util.GetParam ("-p"			,	"") --gets argument after -p when calling script
local sfile = util.GetParam ("-s"			,	"")

if (pfile ~= "") then
	ug_load_script(pfile)
	print("LOADED "..pfile)
	pFileLoaded = true
end

-----------------------------------------------------------------
-- define Home-Directories
----------------------------------------------------------------
ug4_home        = ug_get_root_path().."/"
app_home        = ug4_home.."apps/particle_swarm_optimization/"
common_scripts  = app_home.."scripts/"
geom_home       = app_home.."geometry/"

-----------------------------------------------------------------

--Defining the parameters
--[[
Parameters that need to be optimized: 
alpha = ansteckungsrate 
Kappa = ausbruchsrate 0<=kappa<=1
theta =  0 <=  Sterberate <= 1 -- https://coronavirus.jhu.edu/data/mortality
qq = Inkubationszeit (in days) (5-6 from RKI (the median is 5-6 days))(95%der infizierten Symtome entwickelt,lag das 95.percentil der Inkubationszeit bei10-14)
pp=  duration of desease
]]


--Adding the parameters into the Parameter Manager
-- set the lower bounds and upper bounds for the parameters #PSO requires no initial value
manager=VarDescriptor64()
manager:add("alpha",EFloat64(0.15),EFloat64(0.8))
manager:add("qq",EFloat64(9),EFloat64(12))
--manager:add("kappa",EFloat64(1),EFloat64(1))
--manager:add("theta",EFloat64(0.001),EFloat64(0.4))
--manager:add("pp",EFloat64(9),EFloat64(16))
--[[
]]
--Defining storage place for the the estimated paramteers
estimated_parameters=EVar64Manager()

--Running the Particle Swarm Optimization Algorithm
n_particles=10
n_groups=2
max_iterations=2 --maximum iterations of the PSO algorithm if no convergence is reached beforehand
RunPSO_BiogasEval(app_home,manager,estimated_parameters,n_particles,n_groups,max_iterations) -- calls eval.lua


--[[Generate a lua table with the parameters.
Note: The paramters are converted to double which means they lose
their accumulated error bounds.
--]]

tab={}
for k=0,estimated_parameters:len()-1 do
			
			name=estimated_parameters:get_name(k)
			value=estimated_parameters:get_param(k):get_value_as_double()
			tab[name]=value
end
print("Parameter values converted into lua table:")
print(tab)


print("Execution completed") 



