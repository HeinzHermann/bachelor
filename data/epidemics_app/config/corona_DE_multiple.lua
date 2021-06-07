local corona_DE_multiple ={}


-- Some GLOBALs
local MyDefaultDiffusion = 1e+0 -- km^2 /day

-----------------------------------------
-- D) Initial values ("Anfangswerte")
-----------------------------------------

-- r^2 = 1000 km^2 <=> r = 32 km 
local hauptstaede = {
   Kiel= { -57.267, 290.656 },
   Heinsberg={ -382.283, -168.598 },
   Hamburg={ -41.87, 170.511 },
   Hannover={-50.631, 30.234 },
   Bremen={-125.239,108.326 },
   Wiesbaden={-209.171,-286.336 },
   Mainz={-215.882,-294.626 },
   Stuttgart={-94.5205,-418.207 },
   Munich={85.7937,-515.708 },
   Saarbrucken={ -294.128,-380.767},
   Berlin={ 235.947, 21.7215 },
   Potsdam={ -197.167, 13.3141 },
   Schwerin={72.982,169.179 },
   Dresden={237.898, -179.146 },
   Magdeburg={91.3874, -31.1244 },
   Erfurt={36.1625, -175.894 },
}

-- percentages calculated from number of cases based on RKI report from 
-- 10.03.20, per bundesland. total population from  DESTATIS, 02_bundeslaender.xlsx (31.12.2018)
function InitialinSubsetsG(x,y,t,si)
   value = 1.0
   if (si == 0 ) then
     local r2 = (x-hauptstaede.Kiel[1])*(x-hauptstaede.Kiel[1])+(y-hauptstaede.Kiel[2])*(y-hauptstaede.Kiel[2])
     if (r2 < 1000) then value = 0.9999968930
     end
   end
   if (si == 1 ) then
      local r2 = (x-hauptstaede.Hamburg[1])*(x-hauptstaede.Hamburg[1])+(y-hauptstaede.Hamburg[2])*(y-hauptstaede.Hamburg[2])
     if (r2 < 1000) then value = 0.9999842492
     end
   end
   if (si == 2 ) then
      local r2 = (x-hauptstaede.Hannover[1])*(x-hauptstaede.Hannover[1])+(y-hauptstaede.Hannover[2])*(y-hauptstaede.Hannover[2])
     if (r2 < 1000) then value = 0.9999938615
     end
   end
   if (si == 3 ) then
      local r2 = (x-hauptstaede.Bremen[1])*(x-hauptstaede.Bremen[1])+(y-hauptstaede.Bremen[2])*(y-hauptstaede.Bremen[2])
     if (r2 < 1000) then value = 0.9999941434
     end
   end
   if (si == 4 ) then
      local r2 = (x-hauptstaede.Heinsberg[1])*(x-hauptstaede.Heinsberg[1])+(y-hauptstaede.Heinsberg[2])*(y-hauptstaede.Heinsberg[2])
     if (r2 < 1000) then value = 0.9999730101
     end
   end
   if (si == 5 ) then
      local r2 = (x-hauptstaede.Wiesbaden[1])*(x-hauptstaede.Wiesbaden[1])+(y-hauptstaede.Wiesbaden[2])*(y-hauptstaede.Wiesbaden[2])
     if (r2 < 1000) then value = 0.9999944141
     end
   end
   if (si == 6 ) then
      local r2 = (x-hauptstaede.Mainz[1])*(x-hauptstaede.Mainz[1])+(y-hauptstaede.Mainz[2])*(y-hauptstaede.Mainz[2])
     if (r2 < 1000) then value = 0.9999938798
     end
   end
   if (si == 7 ) then
      local r2 = (x-hauptstaede.Stuttgart[1])*(x-hauptstaede.Stuttgart[1])+(y-hauptstaede.Stuttgart[2])*(y-hauptstaede.Stuttgart[2])
     if (r2 < 1000) then value = 0.9999785899
     end
   end
   if (si == 8 ) then
      local r2 = (x-hauptstaede.Munich[1])*(x-hauptstaede.Munich[1])+(y-hauptstaede.Munich[2])*(y-hauptstaede.Munich[2])
     if (r2 < 1000) then value = 0.9999759879
     end
   end
   if (si == 9 ) then
      local r2 = (x-hauptstaede.Saarbrucken[1])*(x-hauptstaede.Saarbrucken[1])+(y-hauptstaede.Saarbrucken[2])*(y-hauptstaede.Saarbrucken[2])
     if (r2 < 1000) then value = 0.9999929329
     end
   end
   if (si == 10 ) then
      local r2 = (x-hauptstaede.Berlin[1])*(x-hauptstaede.Berlin[1])+(y-hauptstaede.Berlin[2])*(y-hauptstaede.Berlin[2])
     if (r2 < 1000) then value = 0.9999868306
     end
   end
   if (si == 11) then
      local r2 = (x-hauptstaede.Potsdam[1])*(x-hauptstaede.Potsdam[1])+(y-hauptstaede.Potsdam[2])*(y-hauptstaede.Potsdam[2])
     if (r2 < 1000) then value = 0.9999964171
     end
   end
   if (si == 12) then
      local r2 = (x-hauptstaede.Schwerin[1])*(x-hauptstaede.Schwerin[1])+(y-hauptstaede.Schwerin[2])*(y-hauptstaede.Schwerin[2])
     if (r2 < 1000) then value = 0.9999919238
     end
   end
   if (si == 13) then
      local r2 = (x-hauptstaede.Dresden[1])*(x-hauptstaede.Dresden[1])+(y-hauptstaede.Dresden[2])*(y-hauptstaede.Dresden[2])
     if (r2 < 1000) then value = 0.9999946051
     end
   end
   if (si == 14) then
      local r2 = (x-hauptstaede.Magdeburg[1])*(x-hauptstaede.Magdeburg[1])+(y-hauptstaede.Magdeburg[2])*(y-hauptstaede.Magdeburg[2])
     if (r2 < 1000) then value = 0.9999968302
     end
   end
   if (si == 15 ) then
      local r2 = (x-hauptstaede.Erfurt[1])*(x-hauptstaede.Erfurt[1])+(y-hauptstaede.Erfurt[2])*(y-hauptstaede.Erfurt[2])
     if (r2 < 1000) then value = 0.9999981336
     end 
   end
   return value
 end
 
 -- percentages calculated from number of cases based on RKI report from 
 -- 10.03.20, per bundesland. total population from  DESTATIS, 02_bundeslaender.xlsx (31.12.2018) 
 function InitialinSubsetsA(x,y,t,si)
   value = 0.0
   if (si == 0 ) then
      local r2 = (x-hauptstaede.Kiel[1])*(x-hauptstaede.Kiel[1])+(y-hauptstaede.Kiel[2])*(y-hauptstaede.Kiel[2])
     if (r2 < 1000) then value = 0.0000031070
     end
   end
   if (si == 1 ) then
      local r2 = (x-hauptstaede.Hamburg[1])*(x-hauptstaede.Hamburg[1])+(y-hauptstaede.Hamburg[2])*(y-hauptstaede.Hamburg[2])
     if (r2 < 1000) then value= 0.0000157508
     end
   end
   if (si == 2 ) then
      local r2 = (x-hauptstaede.Hannover[1])*(x-hauptstaede.Hannover[1])+(y-hauptstaede.Hannover[2])*(y-hauptstaede.Hannover[2])
     if (r2 < 1000) then value = 0.0000061385
     end  
   end
   if (si == 3 ) then
      local r2 = (x-hauptstaede.Bremen[1])*(x-hauptstaede.Bremen[1])+(y-hauptstaede.Bremen[2])*(y-hauptstaede.Bremen[2])
     if (r2 < 1000) then value = 0.0000058566
     end 
   end
   if (si == 4 ) then
      local r2 = (x-hauptstaede.Heinsberg[1])*(x-hauptstaede.Heinsberg[1])+(y-hauptstaede.Heinsberg[2])*(y-hauptstaede.Heinsberg[2])
      if (r2 < 1000) then value = 0.0000269899
      end 
    end
    if (si == 5 ) then
      local r2 = (x-hauptstaede.Wiesbaden[1])*(x-hauptstaede.Wiesbaden[1])+(y-hauptstaede.Wiesbaden[2])*(y-hauptstaede.Wiesbaden[2])
      if (r2 < 1000) then value = 0.0000055859
      end 
    end
    if (si == 6 ) then
      local r2 = (x-hauptstaede.Mainz[1])*(x-hauptstaede.Mainz[1])+(y-hauptstaede.Mainz[2])*(y-hauptstaede.Mainz[2])
      if (r2 < 1000) then value = 0.0000061202
      end 
    end
    if (si == 7 ) then
      local r2 = (x-hauptstaede.Stuttgart[1])*(x-hauptstaede.Stuttgart[1])+(y-hauptstaede.Stuttgart[2])*(y-hauptstaede.Stuttgart[2])
      if (r2 < 1000) then value = 0.0000214101
      end 
    end
    if (si == 8 ) then
      local r2 = (x-hauptstaede.Munich[1])*(x-hauptstaede.Munich[1])+(y-hauptstaede.Munich[2])*(y-hauptstaede.Munich[2])
      if (r2 < 1000) then value = 0.0000240121
      end 
    end
    if (si == 9 ) then
      local r2 = (x-hauptstaede.Saarbrucken[1])*(x-hauptstaede.Saarbrucken[1])+(y-hauptstaede.Saarbrucken[2])*(y-hauptstaede.Saarbrucken[2])
      if (r2 < 1000) then value = 0.0000070671
      end 
    end
    if (si == 10 ) then
      local r2 = (x-hauptstaede.Berlin[1])*(x-hauptstaede.Berlin[1])+(y-hauptstaede.Berlin[2])*(y-hauptstaede.Berlin[2])
      if (r2 < 1000) then value = 0.0000131694
      end 
    end
    if (si == 11) then
      local r2 = (x-hauptstaede.Potsdam[1])*(x-hauptstaede.Potsdam[1])+(y-hauptstaede.Potsdam[2])*(y-hauptstaede.Potsdam[2])
      if (r2 < 1000) then value = 0.0000035829
      end 
    end
    if (si == 12) then
      local r2 = (x-hauptstaede.Schwerin[1])*(x-hauptstaede.Schwerin[1])+(y-hauptstaede.Schwerin[2])*(y-hauptstaede.Schwerin[2])
      if (r2 < 1000) then value = 0.0000080762
      end 
    end
    if (si == 13) then
      local r2 = (x-hauptstaede.Dresden[1])*(x-hauptstaede.Dresden[1])+(y-hauptstaede.Dresden[2])*(y-hauptstaede.Dresden[2])
      if (r2 < 1000) then value = 0.0000053949
      end 
    end
    if (si == 14) then
      local r2 = (x-hauptstaede.Magdeburg[1])*(x-hauptstaede.Magdeburg[1])+(y-hauptstaede.Magdeburg[2])*(y-hauptstaede.Magdeburg[2])
      if (r2 < 1000) then value = 0.0000031698
      end 
    end
    if (si == 15) then
      local r2 = (x-hauptstaede.Erfurt[1])*(x-hauptstaede.Erfurt[1])+(y-hauptstaede.Erfurt[2])*(y-hauptstaede.Erfurt[2])
      if (r2 < 1000) then value = 0.0000018664
      end 
    end
   return value
 end
 

--[[function testG(x,y)
   for key, val in pairs(hauptstaede) do
      local r2 = (x-val[1])*(x-val[1])+(y-val[2])*(y-val[2])
      if (r2< 1000) then return 0.99
      else return 1.0 end
   end
end

function testA(x,y)
   for key, val in pairs(hauptstaede) do
      local r2 = (x-val[1])*(x-val[1])+(y-val[2])*(y-val[2])
      if (r2< 1000) then return 0.01
      else return 0.0 end
   end
end
]]

--[[  local Heinsberg = { x0= -382.283, y0 =-168.598 } --km
 --local Heinsberg = { x0= -209.283, y0 =-286.598 } --km
 function HeinsbergInitialG(x, y)
   local r2 = (x-Heinsberg.x0)*(x-Heinsberg.x0)+(y-Heinsberg.y0)*(y-Heinsberg.y0)
   if (r2< 1000) then return 0.99
   else return 1.0 end
end

function HeinsbergInitialA(x, y) 
   local r2 = (x-Heinsberg.x0)*(x-Heinsberg.x0)+(y-Heinsberg.y0)*(y-Heinsberg.y0)
   if (r2< 1000) then return 0.01
   else return 0.0 end
end ]]


corona_DE_multiple = {
  grid = {
    filename = "data/DE-ALL_STATES_F_corrected_scaled.ugx",
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

function corona_DE_multiple.create_domain(self)

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


function corona_DE_multiple.set_initial_values(self, u)
    u:set(0.0)
    --Interpolate("testG", u, "g")
    --Interpolate("testA", u, "a")

    for key, val in pairs(corona_DE_multiple.grid.mandatory) do
      Interpolate("InitialinSubsetsG", u, "g",val)
      Interpolate("InitialinSubsetsA", u, "a",val)
    end

end





return corona_DE_multiple