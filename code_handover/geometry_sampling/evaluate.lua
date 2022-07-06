--[[
This is the evaluate.lua file. It is called by the computation subroutine if ConfigOutput in the Evaluation
class is set to File. All evaluations by the problem formulation happen here.
--]]


PrintBuildConfiguration()
ug_load_script("ug_util.lua")

-----------------------------------------------------------------
-- define Home-Directories
----------------------------------------------------------------
ug4_home        = ug_get_root_path().."/"
app_home        = ug4_home.."apps/geometry_sampling/"
common_scripts  = app_home.."scripts/"
geom_home       = app_home.."geometry/"

-----------------------------------------------------------------

--Load Parameters
local pars = "parameters.lua"

local parmfileloaded= false
if(pfile ~= "") then
	local file = assert(loadfile(pars))
	file()
	parmfileloaded = true
end
if parmfileloaded == false then
	print("Parameter file could not be loaded")
end
	

--Configure problem formulation with the new parameter values
v_alpha = parameters.v_alpha:get_value_as_double()
v_qq = parameters.v_qq:get_value_as_double()
--[[
v_kappa = parameters.kappa:get_value_as_double()
v_theta = parameters.theta:get_value_as_double()
v_pp = parameters.pp:get_value_as_double()
--]]


--v_alpha=0.118812645864508
v_kappa = 1.0000000000000000    	-- 0 <=  split sympthomatic/asympthomatic <= 1
v_theta = 0.005000000000000     	-- 0 <=  mortality <= 1
--v_qq = 6				-- incubation time/ time till symptom development (in days)
v_pp = 10 				-- duration of sickness after development of first symptoms (in days)

-- Execute main script
-----------------------------------------------------------------
print("Start of Epidemics-MAIN")
ug_load_script(common_scripts.."epidemics.lua")


