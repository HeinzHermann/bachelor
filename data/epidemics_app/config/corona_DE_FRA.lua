--[[ Sept 2020 01.09 till 07.09
setting inital values for Frankfurt and Wiesbaden. 




]]

local corona_DE_FRA ={}


-- Some GLOBALs
local MyDefaultDiffusion = 1e+0 -- km^2 /day

-----------------------------------------
-- D) Initial values ("Anfangswerte")
-----------------------------------------

-- using real/approx radii -- areas of cities defined by radii pi*r2
local hauptstaede = {
   
   --{x1,x2,density}
   Frankfurt={ -125.856, -257.983, 3074} ,
   Wiesbaden={-166, -240, 1366 },
   
}

-- gesunde based on population - angesteckte, and rest of germany is 1.0 
-- rates calculated by pop. of city 
function InitialinSubsetsG(x,y,t,si)
   value = 1.0
   if (si == 16 or si ==5 ) then
     local r2_f = (x-hauptstaede.Frankfurt[1])*(x-hauptstaede.Frankfurt[1])+(y-hauptstaede.Frankfurt[2])*(y-hauptstaede.Frankfurt[2])
     if (r2_f < 79.03) then value =  0.996487987 end
   end
   
   if(si == 17 or si == 5) then
   local r2_w = (x-hauptstaede.Wiesbaden[1])*(x-hauptstaede.Wiesbaden[1])+(y-hauptstaede.Wiesbaden[2])*(y-hauptstaede.Wiesbaden[2])
   if (r2_w < 64.80) then value =0.996883012 end
   end
   
   return value
 end
 
 
 function InitialinSubsetsA(x,y,t,si)
   value = 0.0
    if (si == 16 or si==5) then
        local r2_f = (x-hauptstaede.Frankfurt[1])*(x-hauptstaede.Frankfurt[1])+(y-hauptstaede.Frankfurt[2])*(y-hauptstaede.Frankfurt[2])
        if (r2_f < 79.03) then value = 0.00351201236 end
      end
      
      if(si ==17 or si == 5) then 
      local r2_w = (x-hauptstaede.Wiesbaden[1])*(x-hauptstaede.Wiesbaden[1])+(y-hauptstaede.Wiesbaden[2])*(y-hauptstaede.Wiesbaden[2])
      if (r2_w < 64.80) then value = 0.003116987 end
      end
   return value
 end
 

corona_DE_FRA = {
  grid = {
    filename = geom_home.."DE-fra_wies_H.ugx",
    mandatory = {"SH","HH","NI","HB",
                 "NW","HE","RP","BW",
                 "BY","SL","BE","BB",
                 "MV","SN","ST","TH", "FRA","WIES"},
  },
  
  regions = 
  {
     -- Quelle: DESTATIS, 02_bundeslaender.xlsx (31.12.2018)  
    {subset = "SH", area= 15804.30, density =  183, diffusion = MyDefaultDiffusion}, 
    {subset = "HH", area=   755.09, density = 2438, diffusion = MyDefaultDiffusion}, 
    {subset = "NI", area= 47709.50, density =  167, diffusion = MyDefaultDiffusion}, 
    {subset = "HB", area=   419.36, density = 1629, diffusion = MyDefaultDiffusion}, 
    {subset = "NW", area= 34112.31, density =  526, diffusion = MyDefaultDiffusion}, 
    {subset = "HE", area= 21115.68, density =  297, diffusion = MyDefaultDiffusion}, 
    {subset = "RP", area= 19858.00, density =  206, diffusion = MyDefaultDiffusion}, 
    {subset = "BW", area= 35748.22, density =  310, diffusion = MyDefaultDiffusion}, 
    {subset = "BY", area= 70541.57, density =  185, diffusion = MyDefaultDiffusion}, 
    {subset = "SL", area=  2571.11, density =  385, diffusion = MyDefaultDiffusion}, 
    {subset = "BE", area=   891.12, density = 4090, diffusion = MyDefaultDiffusion}, 
    {subset = "BB", area= 29654.48, density =   85, diffusion = MyDefaultDiffusion}, 
    {subset = "MV", area= 23294.62, density =   69, diffusion = MyDefaultDiffusion}, 
    {subset = "SN", area= 18449.96, density =  221, diffusion = MyDefaultDiffusion}, 
    {subset = "ST", area= 20454.31, density =  108, diffusion = MyDefaultDiffusion},
    {subset = "TH", area= 16202.37, density =  132, diffusion = MyDefaultDiffusion},
    {subset = "FRA", area= 248.31, density =  3074, diffusion = MyDefaultDiffusion},
    {subset = "WIES", area= 203.93, density =  1366, diffusion = MyDefaultDiffusion},
      
  },
  
  reactionParams = 
  {
    alpha = 4.0,      -- Ansteckunsrate    -- 4.0 (per day and fraction)
    kappa = 0.1,     -- 0 <=  Ausbruchsrate <= 1
    theta = 0.02,   -- 0 <=  Sterberate <= 1
    qq = 14.0,    -- Inkubationszeit (in days)
    pp = 7.0,          -- Dauer der Krankheit (in days)
  }
  
  --[[cities = 
  {
  	{subset = "HE",city= "fra",x=-125.856,y= -257.983, area=248.31,  density =  3074}
  	{subset = "HE", city = "wies",x=-184.378, y=-253.232,area = 203.93,  density =  1366},
  } ]]

}

function corona_DE_FRA.create_domain(self)

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


function corona_DE_FRA.set_initial_values(self, u)
    u:set(0.0)
    --Interpolate("testG", u, "g")
    --Interpolate("testA", u, "a")

    for key, val in pairs(corona_DE_FRA.grid.mandatory) do
      Interpolate("InitialinSubsetsG", u, "g",val)
      Interpolate("InitialinSubsetsA", u, "a",val)
    end

end



return corona_DE_FRA
