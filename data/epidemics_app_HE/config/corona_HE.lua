local corona_HE ={}

-- Some GLOBALs
local MyDefaultDiffusion = 1e+0 -- km^2 /day


-----------------------------------------------------------------
-- define Home-Directories
----------------------------------------------------------------
ug4_home        = ug_get_root_path().."/"
app_home        = ug4_home.."apps/epidemics_app_HE/parameteroptimization/"
common_scripts  = app_home.."scripts/"
geom_home       = app_home.."geometry/"

-----------------------------------------------------------------


-----------------------------------------
-- D) Initial values ("Anfangswerte")
-----------------------------------------

-- set initial values for grid points
-- values are normalized densities of starting values for each bundesland
function InitialinSubsetsS(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.9799327657056 end
	if (si == 2) then value = 0.997675653836333 end
	if (si == 3) then value = 0.978038701559653 end
	if (si == 4) then value = 0.979245690628622 end
	if (si == 5) then value = 0.974859858010988 end
	if (si == 6) then value = 0.957303197704704 end
	if (si == 7) then value = 0.975660502843533 end
	if (si == 8) then value = 0.988054791722735 end
	if (si == 9) then value = 0.985575415126761 end
	if (si == 10) then value = 0.986479943758998 end
	if (si == 11) then value = 0.990966374990725 end
	if (si == 12) then value = 0.982124146456906 end
	if (si == 13) then value = 0.971555027285171 end
	if (si == 14) then value = 0.985819595913111 end
	if (si == 15) then value = 0.98536528316914 end
	if (si == 16) then value = 0.993948505568538 end
	if (si == 17) then value = 0.994929356236327 end
	if (si == 18) then value = 0.995629763606336 end
	if (si == 19) then value = 0.992931094955199 end
	if (si == 20) then value = 0.990026608950932 end
	if (si == 21) then value = 0.991781701014518 end
	if (si == 22) then value = 0.989384250817282 end
	if (si == 23) then value = 0.99749330920879 end
	if (si == 24) then value = 0.99021317474571 end
	if (si == 25) then value = 0.975995385617508 end
	if (si == 26) then value = 0.989433059082379 end
	
	return value
end

function InitialinSubsetsE(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.0000294577822691744 end
	if (si == 2) then value = 0.0000398039339644853 end
	if (si == 3) then value = 0.0000206784876454023 end
	if (si == 4) then value = 0.0000250614719761636 end
	if (si == 5) then value = 0.0000162537594599806 end
	if (si == 6) then value = 0.0000213690904317043 end
	if (si == 7) then value = 0.0000438505014828754 end
	if (si == 8) then value = 0.0000804686789553282 end
	if (si == 9) then value = 0.0000389683340829901 end
	if (si == 10) then value = 0.0000688734346370252 end
	if (si == 11) then value = 0.0000767131898921578 end
	if (si == 12) then value = 0.000018646923674174 end
	if (si == 13) then value = 0.0000693137761646294 end
	if (si == 14) then value = 0.0000381829292846083 end
	if (si == 15) then value = 0.0000421566934523754 end
	if (si == 16) then value = 0.0000545463895122611 end
	if (si == 17) then value = 0.000121812583676153 end
	if (si == 18) then value = 0.000100125766607104 end
	if (si == 19) then value = 0.000174780352396098 end
	if (si == 20) then value = 0.000129063927120072 end
	if (si == 21) then value = 0.0000474309756582744 end
	if (si == 22) then value = 0.000097158269674034 end
	if (si == 23) then value = 0.0000879540628494603 end
	if (si == 24) then value = 0.0000966591674076132 end
	if (si == 25) then value = 0.0000101363152410762 end
	if (si == 26) then value = 0.0000146331743577847 end
	
	return value
end

function InitialinSubsetsI(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.0000294577822691744 end
	if (si == 2) then value = 0.000119411801893456 end
	if (si == 3) then value = 0.000062035462936207 end
	if (si == 4) then value = 0.0000689190479344499 end
	if (si == 5) then value = 0.0000243806391899709 end
	if (si == 6) then value = 0.0000427381808634086 end
	if (si == 7) then value = 0.000122781404152051 end
	if (si == 8) then value = 0.00010058584869416 end
	if (si == 9) then value = 0.000101317668615774 end
	if (si == 10) then value = 0.000097570699069119 end
	if (si == 11) then value = 0.0000913252260620926 end
	if (si == 12) then value = 0.0000466173091854349 end
	if (si == 13) then value = 0.000207941328493888 end
	if (si == 14) then value = 0.000098639233985238 end
	if (si == 15) then value = 0.000105391733630938 end
	if (si == 16) then value = 0.000104896902908194 end
	if (si == 17) then value = 0.000404847704570745 end
	if (si == 18) then value = 0.000246142509575798 end
	if (si == 19) then value = 0.000286952817366729 end
	if (si == 20) then value = 0.000303679828517816 end
	if (si == 21) then value = 0.000214834419158067 end
	if (si == 22) then value = 0.000219505720374669 end
	if (si == 23) then value = 0.000157060826516893 end
	if (si == 24) then value = 0.000186652185338839 end
	if (si == 25) then value = 0.0000304089457232287 end
	if (si == 26) then value = 0.000256080551261232 end
	
	return value
end

function InitialinSubsetsR(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.0186908985665784 end
	if (si == 2) then value = 0.00212600156465616 end
	if (si == 3) then value = 0.0205221122514002 end
	if (si == 4) then value = 0.0201864680979931 end
	if (si == 5) then value = 0.0234213428386808 end
	if (si == 6) then value = 0.0400101790840383 end
	if (si == 7) then value = 0.0234298468517288 end
	if (si == 8) then value = 0.011597875958101 end
	if (si == 9) then value = 0.0136040941624192 end
	if (si == 10) then value = 0.0131108191598906 end
	if (si == 11) then value = 0.00876338962970921 end
	if (si == 12) then value = 0.0171426922111006 end
	if (si == 13) then value = 0.0267672588546926 end
	if (si == 14) then value = 0.0136709970970741 end
	if (si == 15) then value = 0.0142072231206115 end
	if (si == 16) then value = 0.00579274690636097 end
	if (si == 17) then value = 0.0044124471116635 end
	if (si == 18) then value = 0.00390248983468955 end
	if (si == 19) then value = 0.00641635102666182 end
	if (si == 20) then value = 0.00931928656736456 end
	if (si == 21) then value = 0.0075899584254507 end
	if (si == 22) then value = 0.0100989734337441 end
	if (si == 23) then value = 0.0021485921067511 end
	if (si == 24) then value = 0.00912624775422327 end
	if (si == 25) then value = 0.0207032994570434 end
	if (si == 26) then value = 0.0102316065192487 end
	
	return value
end

function InitialinSubsetsD(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.00131742016328306 end
	if (si == 2) then value = 0.0000391288631531809 end
	if (si == 3) then value = 0.00135647223836547 end
	if (si == 4) then value = 0.000473860753474016 end
	if (si == 5) then value = 0.00167816475168118 end
	if (si == 6) then value = 0.00262251593996218 end
	if (si == 7) then value = 0.000743018399103452 end
	if (si == 8) then value = 0.000166277791513993 end
	if (si == 9) then value = 0.000680204708120959 end
	if (si == 10) then value = 0.000242792947405382 end
	if (si == 11) then value = 0.000102196963611769 end
	if (si == 12) then value = 0.000667897099133791 end
	if (si == 13) then value = 0.0014004587554775 end
	if (si == 14) then value = 0.000372584826544995 end
	if (si == 15) then value = 0.000279945283164759 end
	if (si == 16) then value = 0.0000993042326804737 end
	if (si == 17) then value = 0.000131536363762327 end
	if (si == 18) then value = 0.000121478282791893 end
	if (si == 19) then value = 0.00019082084837656 end
	if (si == 20) then value = 0.000221360726065667 end
	if (si == 21) then value = 0.000366075165214664 end
	if (si == 22) then value = 0.000200111758924915 end
	if (si == 23) then value = 0.000113083795092163 end
	if (si == 24) then value = 0.000377266147320253 end
	if (si == 25) then value = 0.00326076966448433 end
	if (si == 26) then value = 0.0000646206727531499 end
	
	return value
end


-- set up grid information
corona_HE = {
	grid = {
		filename = geom_home.."DE-HE.ugx",
		mandatory = {
				 "Werra-Meissner-Kreis"
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
				 ,"Bergstrasse"
				 },
	},
	regions = {
		 {subset = "Werra-Meissner-Kreis",	area = 1024.7,		density = 97.39,	diffusion = MyDefaultDiffusion}
		,{subset = "Kassel-City",		area = 106.78,		density = 1877.94,	diffusion = MyDefaultDiffusion}
		,{subset = "Kassel",			area = 1292.92,		density = 183.31,	diffusion = MyDefaultDiffusion}
		,{subset = "Waldeck-Frankenberg",	area = 1848,		density = 84.56,	diffusion = MyDefaultDiffusion}
		,{subset = "Hersfeld-Rotenburg",	area = 1097.12,		density = 109.19,	diffusion = MyDefaultDiffusion}
		,{subset = "Schwalm-Eder-Kreis",	area = 1538.51,		density = 116.50,	diffusion = MyDefaultDiffusion}
		,{subset = "Fulda",			area = 1380.4,		density = 161.56,	diffusion = MyDefaultDiffusion}
		,{subset = "Marburg-Biedenkopf",	area = 1262.55,		density = 194.52,	diffusion = MyDefaultDiffusion}
		,{subset = "Lahn-Dill-Kreis",		area = 1066.52,		density = 237.15,	diffusion = MyDefaultDiffusion}
		,{subset = "Limburg-Weilburg",		area = 738.48,		density = 232.76,	diffusion = MyDefaultDiffusion}
		,{subset = "Giessen",			area = 854.67,		density = 317.43,	diffusion = MyDefaultDiffusion}
		,{subset = "Vogelsbergkreis",		area = 1458.99,		density = 72.20,	diffusion = MyDefaultDiffusion}
		,{subset = "Main-Kinzig-Kreis",		area = 1397.55,		density = 300.91,	diffusion = MyDefaultDiffusion}
		,{subset = "Wetteraukreis",		area = 1100.69,		density = 281.69,	diffusion = MyDefaultDiffusion}
		,{subset = "Rheingau-Taunus-Kreis",	area = 811.48,		density = 230.44,	diffusion = MyDefaultDiffusion}
		,{subset = "Hochtaunuskreis",		area = 482.02,		density = 491.47,	diffusion = MyDefaultDiffusion}
		,{subset = "Wiesbaden",			area = 203.93,		density = 1366.19,	diffusion = MyDefaultDiffusion}
		,{subset = "Main-Taunus-Kreis",		area = 222.39,		density = 1073.23,	diffusion = MyDefaultDiffusion}
		,{subset = "Frankfurt-am-Main",		area = 248.3,		density = 3066.42,	diffusion = MyDefaultDiffusion}
		,{subset = "Offenbach-am-Main",		area = 44.89,		density = 2905.35,	diffusion = MyDefaultDiffusion}
		,{subset = "Offenbach",			area = 356.3,		density = 997.71,	diffusion = MyDefaultDiffusion}
		,{subset = "Gross-Gerau",		area = 453.04,		density = 606.95,	diffusion = MyDefaultDiffusion}
		,{subset = "Darmstadt",			area = 122.2,		density = 1299.42,	diffusion = MyDefaultDiffusion}
		,{subset = "Darmstadt-Dieburg",		area = 658.65,		density = 451.10,	diffusion = MyDefaultDiffusion}
		,{subset = "Odenwaldkreis",		area = 623.98,		density = 154.31,	diffusion = MyDefaultDiffusion}
		,{subset = "Bergstrasse",		area = 719.52,		density = 375.90,	diffusion = MyDefaultDiffusion}
  }
}

-- create domain and initialize densities
function corona_HE.create_domain(self)
    print("self.grid.filename = "..self.grid.filename)
    local domain = util.CreateDomain(self.grid.filename, 0)
    self.myCompositeDensity =  CompositeUserNumber(false) -- discontinuous data

    -- initialize density
    for key, value in pairs(self.regions) do								-- for every value in regions
       local si = domain:subset_handler():get_subset_index(value.subset)	-- get the si value of subset
       print("Initialize "..key..":"..value.subset.."(si="..si..")")
       self.myCompositeDensity:add(si, ConstUserNumber(value.density))		-- used for discontinous data
    end
    return domain
end

-- set initial values (calls initialSubsetsX(t, si))
function corona_HE.set_initial_values(self, u)

	u:set(0.0)

	for key, val in pairs(corona_HE.grid.mandatory) do
      Interpolate("InitialinSubsetsS", u, "s",val)
      Interpolate("InitialinSubsetsE", u, "e",val)
      Interpolate("InitialinSubsetsI", u, "i",val)
      Interpolate("InitialinSubsetsR", u, "r",val)
      Interpolate("InitialinSubsetsD", u, "d",val)
    end
end


return corona_HE
