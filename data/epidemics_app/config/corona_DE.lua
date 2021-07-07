local corona_DE ={}


-- Some GLOBALs
local MyDefaultDiffusion = 1e+0 -- km^2 /day

-----------------------------------------
-- D) Initial values ("Anfangswerte")
-----------------------------------------

-- r^2 = 1000 km^2 <=> r = 32 km 
local Heinsberg = { x0= -382.283, y0 =-168.598 } -- km
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
  
  
  
corona_DE = {
  grid = {
    filename = "data/DE-ALL_STATES_F.ugx",
    mandatory = {"SH","HH","NI","HB",
                 "NW","HE","RP","BW",
                 "BY","SL","BE","BB",
                 "MV","SN","ST","TH"},
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
  }
  

}

function corona_DE.create_domain(self)

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


function corona_DE.set_initial_values(self, u)
    u:set(0.0)
    Interpolate("HeinsbergInitialG", u, "g")
    Interpolate("HeinsbergInitialA", u, "a")
end





return corona_DE