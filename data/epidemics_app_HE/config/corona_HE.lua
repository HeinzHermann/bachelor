local corona_HE ={}

-- Some GLOBALs
local MyDefaultDiffusion = 1e+0 -- km^2 /day

-----------------------------------------
-- D) Initial values ("Anfangswerte")
-----------------------------------------

-- set initial values for grid points
-- values are normalized densities of starting values for each bundesland
function InitialinSubsetsS(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.997511144873358 end
	if (si == 2) then value = 0.997378644157162 end
	if (si == 3) then value = 0.997373643919837 end
	if (si == 4) then value = 0.998536965577164 end
	if (si == 5) then value = 0.995685606218047 end
	if (si == 6) then value = 0.996396837223785 end
	if (si == 7) then value = 0.997099015826573 end
	if (si == 8) then value = 0.998893616328921 end
	if (si == 9) then value = 0.998235739884119 end
	if (si == 10) then value = 0.997597088646534 end
	if (si == 11) then value = 0.998549689692490 end
	if (si == 12) then value = 0.998407688589383 end
	if (si == 13) then value = 0.997156692562344 end
	if (si == 14) then value = 0.998282556509691 end
	if (si == 15) then value = 0.997631166170492 end
	if (si == 16) then value = 0.998326857104325 end
	if (si == 17) then value = 0.995072991392964 end
	if (si == 18) then value = 0.997425255071119 end
	if (si == 19) then value = 0.996270111948991 end
	if (si == 20) then value = 0.996324933909934 end
	if (si == 21) then value = 0.996982029613133 end
	if (si == 22) then value = 0.996859997969514 end
	if (si == 23) then value = 0.997480775996381 end
	if (si == 24) then value = 0.997914049431318 end
	if (si == 25) then value = 0.995173326167394 end
	if (si == 26) then value = 0.997955787446173 end
	
	return value
end

function InitialinSubsetsE(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.000029986206345 end
	if (si == 2) then value = 0.000039792878070 end
	if (si == 3) then value = 0.000049741592427 end
	if (si == 4) then value = 0.000025555186425 end
	if (si == 5) then value = 0.000041564487302 end
	if (si == 6) then value = 0.000022241745532 end
	if (si == 7) then value = 0.000016624551137 end
	if (si == 8) then value = 0.000081351740520 end
	if (si == 9) then value = 0.000039468906396 end
	if (si == 10) then value = 0.000069649604448 end
	if (si == 11) then value = 0.000077300803192 end
	if (si == 12) then value = 0.000018956088222 end
	if (si == 13) then value = 0.000071141970917 end
	if (si == 14) then value = 0.000038666645185 end
	if (si == 15) then value = 0.000042681690622 end
	if (si == 16) then value = 0.000054788054518 end
	if (si == 17) then value = 0.000121831485556 end
	if (si == 18) then value = 0.000100314737489 end
	if (si == 19) then value = 0.000175370175030 end
	if (si == 20) then value = 0.000114607050626 end
	if (si == 21) then value = 0.000047681688268 end
	if (si == 22) then value = 0.000097898446678 end
	if (si == 23) then value = 0.000087952957732 end
	if (si == 24) then value = 0.000097411540244 end
	if (si == 25) then value = 0.000010335490006 end
	if (si == 26) then value = 0.000014759657428 end
	
	return value
end

function InitialinSubsetsI(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.000029986206345 end
	if (si == 2) then value = 0.000104456304933 end
	if (si == 3) then value = 0.000149224777282 end
	if (si == 4) then value = 0.000044721576244 end
	if (si == 5) then value = 0.000116380564446 end
	if (si == 6) then value = 0.000055604363830 end
	if (si == 7) then value = 0.000024936826706 end
	if (si == 8) then value = 0.000101689675651 end
	if (si == 9) then value = 0.000067097140872 end
	if (si == 10) then value = 0.000098670272968 end
	if (si == 11) then value = 0.000095705756333 end
	if (si == 12) then value = 0.000056868264665 end
	if (si == 13) then value = 0.000244254100149 end
	if (si == 14) then value = 0.000099888833395 end
	if (si == 15) then value = 0.000117374649210 end
	if (si == 16) then value = 0.000118005040501 end
	if (si == 17) then value = 0.000408493804511 end
	if (si == 18) then value = 0.000259146405180 end
	if (si == 19) then value = 0.000291847380833 end
	if (si == 20) then value = 0.000267416451460 end
	if (si == 21) then value = 0.000227189220573 end
	if (si == 22) then value = 0.000242933182497 end
	if (si == 23) then value = 0.000169623561341 end
	if (si == 24) then value = 0.000211618173634 end
	if (si == 25) then value = 0.000031006470017 end
	if (si == 26) then value = 0.000265673833710 end
	
	return value
end

function InitialinSubsetsR(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.002268956280111 end
	if (si == 2) then value = 0.002432339672007 end
	if (si == 3) then value = 0.002352777321813 end
	if (si == 4) then value = 0.001360813677136 end
	if (si == 5) then value = 0.003898748908932 end
	if (si == 6) then value = 0.003308459647913 end
	if (si == 7) then value = 0.002668240457508 end
	if (si == 8) then value = 0.000907071906803 end
	if (si == 9) then value = 0.001578756255822 end
	if (si == 10) then value = 0.002193962540121 end
	if (si == 11) then value = 0.001262579785472 end
	if (si == 12) then value = 0.001459618793066 end
	if (si == 13) then value = 0.002402227217970 end
	if (si == 14) then value = 0.001536999146112 end
	if (si == 15) then value = 0.002166095799055 end
	if (si == 16) then value = 0.001475063006263 end
	if (si == 17) then value = 0.002644459892358 end
	if (si == 18) then value = 0.002148407294553 end
	if (si == 19) then value = 0.003168441744384 end
	if (si == 20) then value = 0.003216637887563 end
	if (si == 21) then value = 0.002616883244374 end
	if (si == 22) then value = 0.002744782375379 end
	if (si == 23) then value = 0.002148565110318 end
	if (si == 24) then value = 0.001706381463592 end
	if (si == 25) then value = 0.004134196002232 end
	if (si == 26) then value = 0.001752709319617 end
	
	return value
end

function InitialinSubsetsD(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.000159926433840 end
	if (si == 2) then value = 0.000044766987828 end
	if (si == 3) then value = 0.000074612388641 end
	if (si == 4) then value = 0.000031943983031 end
	if (si == 5) then value = 0.000257699821273 end
	if (si == 6) then value = 0.000216857018939 end
	if (si == 7) then value = 0.000191182338077 end
	if (si == 8) then value = 0.000016270348104 end
	if (si == 9) then value = 0.000078937812791 end
	if (si == 10) then value = 0.000040628935928 end
	if (si == 11) then value = 0.000014723962513 end
	if (si == 12) then value = 0.000056868264665 end
	if (si == 13) then value = 0.000125684148620 end
	if (si == 14) then value = 0.000041888865617 end
	if (si == 15) then value = 0.000042681690622 end
	if (si == 16) then value = 0.000025286794393 end
	if (si == 17) then value = 0.001752223424611 end
	if (si == 18) then value = 0.000066876491659 end
	if (si == 19) then value = 0.000094228750762 end
	if (si == 20) then value = 0.000076404700417 end
	if (si == 21) then value = 0.000126216233651 end
	if (si == 22) then value = 0.000054388025932 end
	if (si == 23) then value = 0.000113082374227 end
	if (si == 24) then value = 0.000070539391211 end
	if (si == 25) then value = 0.000651135870352 end
	if (si == 26) then value = 0.000011069743071 end
	
	return value
end


-- set up grid information
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
	regions = {
		 {subset = "Werra-Meissner-Kreis",	area = 1024.7,		density = 97.39,	diffusion = MyDefaultDiffusion}
		,{subset = "Kassel-City",		area = 106.78,		density = 1877.94,	diffusion = MyDefaultDiffusion}
		,{subset = "Kassel",			area = 1292.92,		density = 155.10,	diffusion = MyDefaultDiffusion}
		,{subset = "Waldeck-Frankenberg",	area = 1848,		density = 84.56,	diffusion = MyDefaultDiffusion}
		,{subset = "Hersfeld-Rotenburg",	area = 1097.12,		density = 109.19,	diffusion = MyDefaultDiffusion}
		,{subset = "Schwalm-Eder-Kreis",	area = 153.15,		density = 116.50,	diffusion = MyDefaultDiffusion}
		,{subset = "Fulda",			area = 1380.4,		density = 86.90,	diffusion = MyDefaultDiffusion}
		,{subset = "Marburg-Biedenkopf",	area = 1262.55,		density = 194.52,	diffusion = MyDefaultDiffusion}
		,{subset = "Lahn-Dill-Kreis",		area = 1066.52,		density = 237.15,	diffusion = MyDefaultDiffusion}
		,{subset = "Limburg-Weilburg",		area = 738.48,		density = 232.76,	diffusion = MyDefaultDiffusion}
		,{subset = "Giessen",			area = 854.67,		density = 317.43,	diffusion = MyDefaultDiffusion}
		,{subset = "Vogelsbergkreis",		area = 1458.99,		density = 72.20,	diffusion = MyDefaultDiffusion}
		,{subset = "Main-Kinzig-Kreis",		area = 1397.55,		density = 300.91,	diffusion = MyDefaultDiffusion}
		,{subset = "Wetteraukreis",		area = 100.69,		density = 281.49,	diffusion = MyDefaultDiffusion}
		,{subset = "Rheingau-Taunus-Kreis",	area = 811.48,		density = 230.44,	diffusion = MyDefaultDiffusion}
		,{subset = "Hochtaunuskreis",		area = 482.02,		density = 491.47,	diffusion = MyDefaultDiffusion}
		,{subset = "Wiesbaden",			area = 20.93,		density = 1361.92,	diffusion = MyDefaultDiffusion}
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
