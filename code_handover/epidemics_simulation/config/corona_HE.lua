local corona_HE ={}

-- Some GLOBALs
local MyDefaultDiffusion = 1e+0 -- km^2 /day


-----------------------------------------------------------------
-- define Home-Directories
----------------------------------------------------------------
ug4_home        = ug_get_root_path().."/"
app_home        = ug4_home.."apps/epidemics_simulation/"
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
	if (si == 1) then value = 0.997511144873358 end
	if (si == 2) then value = 0.997363813616649 end
	if (si == 3) then value = 0.997805971975511 end
	if (si == 4) then value = 0.998511448430952 end
	if (si == 5) then value = 0.997099015826573 end
	if (si == 6) then value = 0.996407918149466 end
	if (si == 7) then value = 0.997641498858862 end
	if (si == 8) then value = 0.998666140714021 end
	if (si == 9) then value = 0.998200281797982 end
	if (si == 10) then value = 0.997597088646534 end
	if (si == 11) then value = 0.998553376008127 end
	if (si == 12) then value = 0.998417151631187 end
	if (si == 13) then value = 0.997187500741067 end
	if (si == 14) then value = 0.998282600780402 end

	if (si == 15) then value = 0.99764182401178 end
	if (si == 16) then value = 0.998339521495611 end
	if (si == 17) then value = 0.996744541633615 end
	if (si == 18) then value = 0.997437976461148 end
	if (si == 19) then value = 0.996274067404437 end
	if (si == 20) then value = 0.996271735476576 end
	if (si == 21) then value = 0.996993341597904 end
	if (si == 22) then value = 0.996881877544805 end
	if (si == 23) then value = 0.99749330920879 end
	if (si == 24) then value = 0.997937527922311 end
	if (si == 25) then value = 0.995173326167394 end
	if (si == 26) then value = 0.997963212368319 end
	
	return value
end

function InitialinSubsetsE(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.0000299862063450813 end
	if (si == 2) then value = 0.0000397914925788866 end
	if (si == 3) then value = 0.0000210964233123916 end
	if (si == 4) then value = 0.0000255545333742206 end
	if (si == 5) then value = 0.0000166245511371193 end
	if (si == 6) then value = 0.0000222419928825623 end
	if (si == 7) then value = 0.0000448384247364622 end
	if (si == 8) then value = 0.0000813328832913791 end
	if (si == 9) then value = 0.0000394675044302274 end
	if (si == 10) then value = 0.0000696496044482881 end
	if (si == 11) then value = 0.0000773005186496704 end
	if (si == 12) then value = 0.0000189562678899778 end
	if (si == 13) then value = 0.0000711424770387655 end
	if (si == 14) then value = 0.0000386656484712569 end
	if (si == 15) then value = 0.0000426819183388197 end
	if (si == 16) then value = 0.0000547873618199519 end
	if (si == 17) then value = 0.000122034822995668 end
	if (si == 18) then value = 0.000100307610004012 end
	if (si == 19) then value = 0.000175368797964675 end
	if (si == 20) then value = 0.000129878067414357 end
	if (si == 21) then value = 0.0000476802171974129 end
	if (si == 22) then value = 0.0000978945421979863 end
	if (si == 23) then value = 0.0000879540628494603 end
	if (si == 24) then value = 0.0000974131763077719 end
	if (si == 25) then value = 0.0000103354900055812 end
	if (si == 26) then value = 0.0000147593306643544 end
	
	return value
end

function InitialinSubsetsI(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.0000299862063450813 end
	if (si == 2) then value = 0.00011937447773666 end
	if (si == 3) then value = 0.0000632892699371748 end
	if (si == 4) then value = 0.0000702749667791066 end
	if (si == 5) then value = 0.0000249368267056789 end
	if (si == 6) then value = 0.0000444839857651246 end
	if (si == 7) then value = 0.000125547589262094 end
	if (si == 8) then value = 0.000101666104114224 end
	if (si == 9) then value = 0.000102615511518591 end
	if (si == 10) then value = 0.0000986702729684081 end
	if (si == 11) then value = 0.0000920244269638933 end
	if (si == 12) then value = 0.0000473906697249446 end
	if (si == 13) then value = 0.000213427431116297 end
	if (si == 14) then value = 0.0000998862585507471 end
	if (si == 15) then value = 0.000106704795847049 end
	if (si == 16) then value = 0.000105360311192215 end
	if (si == 17) then value = 0.000405586323485602 end
	if (si == 18) then value = 0.000246589541259864 end
	if (si == 19) then value = 0.000287918922031556 end
	if (si == 20) then value = 0.000305595452739663 end
	if (si == 21) then value = 0.000215963336717694 end
	if (si == 22) then value = 0.000221169150891747 end
	if (si == 23) then value = 0.000157060826516893 end
	if (si == 24) then value = 0.000188108202525353 end
	if (si == 25) then value = 0.0000310064700167435 end
	if (si == 26) then value = 0.000258288286626202 end
	
	return value
end

function InitialinSubsetsR(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.00226895628011115 end
	if (si == 2) then value = 0.00243225498388445 end
	if (si == 3) then value = 0.00197884450670233 end
	if (si == 4) then value = 0.00136077890217725 end
	if (si == 5) then value = 0.00266824045750765 end
	if (si == 6) then value = 0.00330849644128114 end
	if (si == 7) then value = 0.00212085749003466 end
	if (si == 8) then value = 0.00113459372191474 end
	if (si == 9) then value = 0.0015787001772091 end
	if (si == 10) then value = 0.00219396254012107 end
	if (si == 11) then value = 0.00126257513794462 end
	if (si == 12) then value = 0.00145963262752829 end
	if (si == 13) then value = 0.00240224430800898 end
	if (si == 14) then value = 0.00153695952673246 end
	if (si == 15) then value = 0.0021661073556951 end
	if (si == 16) then value = 0.00147504435669101 end
	if (si == 17) then value = 0.00264887351090597 end
	if (si == 18) then value = 0.00214825464758593 end
	if (si == 19) then value = 0.00316841686471999 end
	if (si == 20) then value = 0.00321639214008496 end
	if (si == 21) then value = 0.00261680250854037 end
	if (si == 22) then value = 0.00274467290532873 end
	if (si == 23) then value = 0.0021485921067511 end
	if (si == 24) then value = 0.00170641012290856 end
	if (si == 25) then value = 0.00413419600223247 end
	if (si == 26) then value = 0.00175267051639208 end
	
	return value
end

function InitialinSubsetsD(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.000159926433840433 end
	if (si == 2) then value = 0.0000447654291512475 end
	if (si == 3) then value = 0.000130797824536828 end
	if (si == 4) then value = 0.0000319431667177757 end
	if (si == 5) then value = 0.000191182338076872 end
	if (si == 6) then value = 0.000216859430604982 end
	if (si == 7) then value = 0.0000672576371046932 end
	if (si == 8) then value = 0.0000162665766582758 end
	if (si == 9) then value = 0.0000789350088604547 end
	if (si == 10) then value = 0.000040628935928168 end
	if (si == 11) then value = 0.0000147239083142229 end
	if (si == 12) then value = 0.0000568688036699335 end
	if (si == 13) then value = 0.000125685042768486 end
	if (si == 14) then value = 0.0000418877858438617 end
	if (si == 15) then value = 0.0000426819183388197 end
	if (si == 16) then value = 0.0000252864746861316 end
	if (si == 17) then value = 0.0000789637089971968 end
	if (si == 18) then value = 0.0000668717400026749 end
	if (si == 19) then value = 0.000094228010846691 end
	if (si == 20) then value = 0.0000763988631849158 end
	if (si == 21) then value = 0.000126212339640211 end
	if (si == 22) then value = 0.000054385856776659 end
	if (si == 23) then value = 0.000113083795092163 end
	if (si == 24) then value = 0.0000705405759470072 end
	if (si == 25) then value = 0.000651135870351613 end
	if (si == 26) then value = 0.0000110694979982658 end
	
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
		 {subset = "Werra-Meissner-Kreis",	area = 1024.7,		density = 97.6344295891481,	diffusion = MyDefaultDiffusion}
		,{subset = "Kassel-City",		area = 106.78,		density = 1882.82449896984,	diffusion = MyDefaultDiffusion}
		,{subset = "Kassel",			area = 1292.92,		density = 183.311419113325,	diffusion = MyDefaultDiffusion}
		,{subset = "Waldeck-Frankenberg",	area = 1848.44,		density = 84.6811365259354,	diffusion = MyDefaultDiffusion}
		,{subset = "Hersfeld-Rotenburg",	area = 1097.12,		density = 109.654367799329,	diffusion = MyDefaultDiffusion}
		,{subset = "Schwalm-Eder-Kreis",	area = 1538.15,		density = 116.919676234437,	diffusion = MyDefaultDiffusion}
		,{subset = "Fulda",			area = 1380.4,		density = 161.564039408867,	diffusion = MyDefaultDiffusion}
		,{subset = "Marburg-Biedenkopf",	area = 1262.55,		density = 194.766939923171,	diffusion = MyDefaultDiffusion}
		,{subset = "Lahn-Dill-Kreis",		area = 1066.52,		density = 237.569853354836,	diffusion = MyDefaultDiffusion}
		,{subset = "Limburg-Weilburg",		area = 738.48,		density = 233.304896544253,	diffusion = MyDefaultDiffusion}
		,{subset = "Giessen",			area = 854.67,		density = 317.86186481332,	diffusion = MyDefaultDiffusion}
		,{subset = "Vogelsbergkreis",		area = 1458.99,		density = 72.3144092831342,	diffusion = MyDefaultDiffusion}
		,{subset = "Main-Kinzig-Kreis",		area = 1397.55,		density = 301.734463883224,	diffusion = MyDefaultDiffusion}
		,{subset = "Wetteraukreis",		area = 1100.69,		density = 281.962223696045,	diffusion = MyDefaultDiffusion}
		,{subset = "Rheingau-Taunus-Kreis",	area = 811.48,		density = 230.97673386898,	diffusion = MyDefaultDiffusion}
		,{subset = "Hochtaunuskreis",		area = 482.02,		density = 492.263806481059,	diffusion = MyDefaultDiffusion}
		,{subset = "Wiesbaden",			area = 203.93,		density = 1366.19918599519,	diffusion = MyDefaultDiffusion}
		,{subset = "Main-Taunus-Kreis",		area = 222.39,		density = 1075.87571383605,	diffusion = MyDefaultDiffusion}
		,{subset = "Frankfurt-am-Main",		area = 248.3,		density = 3077.34192509062,	diffusion = MyDefaultDiffusion}
		,{subset = "Offenbach-am-Main",		area = 44.89,		density = 2915.83871686344,	diffusion = MyDefaultDiffusion}
		,{subset = "Offenbach",			area = 356.3,		density = 1000.67920291889,	diffusion = MyDefaultDiffusion}
		,{subset = "Gross-Gerau",		area = 453.04,		density = 608.791718170581,	diffusion = MyDefaultDiffusion}
		,{subset = "Darmstadt",			area = 122.2,		density = 1302.569558101472,	diffusion = MyDefaultDiffusion}
		,{subset = "Darmstadt-Dieburg",		area = 658.65,		density = 451.98663933804,	diffusion = MyDefaultDiffusion}
		,{subset = "Odenwaldkreis",		area = 623.98,		density = 155.059457033879,	diffusion = MyDefaultDiffusion}
		,{subset = "Bergstrasse",		area = 719.52,		density = 376.66082944185,	diffusion = MyDefaultDiffusion}
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
