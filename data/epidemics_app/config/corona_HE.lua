local corona_HE ={}


-- Some GLOBALs
local MyDefaultDiffusion = 1e+0 -- km^2 /day

-----------------------------------------
-- D) Initial values ("Anfangswerte")
-----------------------------------------

-- \begin{???}
-- r^2 = 1000 km^2 <=> r = 32 km 
local Heinsberg = { x0= -337.283, y0 =-150.598 } -- km
function HeinsbergInitialG(x, y)
   local r2 = (x-Heinsberg.x0)*(x-Heinsberg.x0)+(y-Heinsberg.y0)*(y-Heinsberg.y0)
   if (r2< 1000) then return 0.99
   else return 1.0 end
end

function HeinsbergInitialA(x, y) 
   local r2 = (x-Heinsberg.x0)*(x-Heinsberg.x0)+(y-Heinsberg.y0)*(y-Heinsberg.y0)
   if (r2< 1000) then return 0.01
   else return 0.0 end
end
-- \end{???}  
  
  
corona_HE = {
  grid = {
    filename = "DE-HE.ugx",
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
	 {subset = "Werra-Meissner-Kreis",	area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Kassel-City",			area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Kassel",				area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Waldeck-Frankenberg",	area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Hersfeld-Rotenburg",	area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Schwalm-Eder-Kreis",	area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Fulda",					area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Marburg-Biedenkopf",	area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Lahn-Dill-Kreis",		area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Limburg-Weilburg",		area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Giessen",				area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Vogelsbergkreis",		area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Main-Kinzig-Kreis",		area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Wetteraukreis",			area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Rheingau-Taunus-Kreis",	area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Hochtaunuskreis",		area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Wiesbaden",				area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Main-Taunus-Kreis",		area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Frankfurt-am-Main",		area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Offenbach-am-Main",		area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Offenbach",				area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Gross-Gerau",			area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Darmstadt",				area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Darmstadt-Dieburg",		area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Odenwaldkreis",			area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
	,{subset = "Bergstrasse",			area = 0,		density = 0,	diffusion = MyDefaultDiffusion}
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
    Interpolate("HeinsbergInitialG", u, "g")
    Interpolate("HeinsbergInitialA", u, "a")
end





return corona_HE