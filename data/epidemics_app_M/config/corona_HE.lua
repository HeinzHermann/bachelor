local corona_HE ={}


-- Some GLOBALs
local MyDefaultDiffusion = 1e+0 -- km^2 /day

-----------------------------------------
-- D) Initial values ("Anfangswerte")
-----------------------------------------
  
  
corona_HE = {
  grid = {
    filename = "geometry/DE-HE.ugx",
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
  regions = 
  {
     -- Quelle: DESTATIS, 02_bundeslaender.xlsx (31.12.2018)
	 {subset = "Werra-Meissner-Kreis",	area = 1024.7,		density = 97.39,	diffusion = MyDefaultDiffusion}
	,{subset = "Kassel-City",			area = 106.78,		density = 1877.94,	diffusion = MyDefaultDiffusion}
	,{subset = "Kassel",				area = 1292.92,		density = 155.10,	diffusion = MyDefaultDiffusion}
	,{subset = "Waldeck-Frankenberg",	area = 1848,		density = 84.56,	diffusion = MyDefaultDiffusion}
	,{subset = "Hersfeld-Rotenburg",	area = 1097.12,		density = 109.19,	diffusion = MyDefaultDiffusion}
	,{subset = "Schwalm-Eder-Kreis",	area = 153.15,		density = 116.50,	diffusion = MyDefaultDiffusion}
	,{subset = "Fulda",					area = 1380.4,		density = 86.90,	diffusion = MyDefaultDiffusion}
	,{subset = "Marburg-Biedenkopf",	area = 1262.55,		density = 194.52,	diffusion = MyDefaultDiffusion}
	,{subset = "Lahn-Dill-Kreis",		area = 1066.52,		density = 237.15,	diffusion = MyDefaultDiffusion}
	,{subset = "Limburg-Weilburg",		area = 738.48,		density = 232.76,	diffusion = MyDefaultDiffusion}
	,{subset = "Giessen",				area = 854.67,		density = 317.43,	diffusion = MyDefaultDiffusion}
	,{subset = "Vogelsbergkreis",		area = 1458.99,		density = 72.20,	diffusion = MyDefaultDiffusion}
	,{subset = "Main-Kinzig-Kreis",		area = 1397.55,		density = 300.91,	diffusion = MyDefaultDiffusion}
	,{subset = "Wetteraukreis",			area = 100.69,		density = 281.49,	diffusion = MyDefaultDiffusion}
	,{subset = "Rheingau-Taunus-Kreis",	area = 811.48,		density = 230.44,	diffusion = MyDefaultDiffusion}
	,{subset = "Hochtaunuskreis",		area = 482.02,		density = 491.47,	diffusion = MyDefaultDiffusion}
	,{subset = "Wiesbaden",				area = 20..93,		density = 1361.92,	diffusion = MyDefaultDiffusion}
	,{subset = "Main-Taunus-Kreis",		area = 222.39,		density = 1073.23,	diffusion = MyDefaultDiffusion}
	,{subset = "Frankfurt-am-Main",		area = 248.3,		density = 3066.42,	diffusion = MyDefaultDiffusion}
	,{subset = "Offenbach-am-Main",		area = 44.89,		density = 2905.35,	diffusion = MyDefaultDiffusion}
	,{subset = "Offenbach",				area = 356.3,		density = 997.71,	diffusion = MyDefaultDiffusion}
	,{subset = "Gross-Gerau",			area = 453.04,		density = 606.95,	diffusion = MyDefaultDiffusion}
	,{subset = "Darmstadt",				area = 122.2,		density = 1299.42,	diffusion = MyDefaultDiffusion}
	,{subset = "Darmstadt-Dieburg",		area = 658.65,		density = 451.10,	diffusion = MyDefaultDiffusion}
	,{subset = "Odenwaldkreis",			area = 623.98,		density = 154.31,	diffusion = MyDefaultDiffusion}
	,{subset = "Bergstrasse",			area = 719.52,		density = 375.90,	diffusion = MyDefaultDiffusion}
  }
  

}

function corona_HE.create_domain(self)

    local domain = util.CreateDomain(self.grid.filename, 0) 
    self.myCompositeDensity =  CompositeUserNumber(false) -- discontinuous data
    
    -- initialize density
    for key, value in pairs(self.regions) do
       local si = domain:subset_handler():get_subset_index(value.subset)
       print("Initialize "..key..":"..value.subset.."(si="..si..")")
       self.myCompositeDensity:add(si, ConstUserNumber(value.density))
    end
	
    return domain
end


function corona_HE.set_initial_values(self, u)
    u:set(0.0)
	
	for key, val in pairs(corona_HE.grid.mandatory) do
      Interpolate("InitialinSubsetsG", u, "g",val)
      Interpolate("InitialinSubsetsA", u, "a",val)
    end
	
end





return corona_HE