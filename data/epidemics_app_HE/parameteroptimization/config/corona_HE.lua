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
	if (si == 1) then value = 0.997511144873358 end
	if (si == 2) then value = 0.997378644157162 end
	if (si == 3) then value = 0.997810108102178 end
	if (si == 4) then value = 0.998536965577164 end
	if (si == 5) then value = 0.997099015826573 end
	if (si == 6) then value = 0.996396837223785 end
	if (si == 7) then value = 0.997373643919836 end
	if (si == 8) then value = 0.998666135289668 end
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
	if (si == 20) then value = 0.996309709360961 end
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
	if (si == 1) then value = 0.0000299862063450813 end
	if (si == 2) then value = 0.0000397928780696475 end
	if (si == 3) then value = 0.0000210972244491515 end
	if (si == 4) then value = 0.000025555186425085 end
	if (si == 5) then value = 0.0000166245511371193 end
	if (si == 6) then value = 0.0000222417455321894 end
	if (si == 7) then value = 0.00004974159242734 end
	if (si == 8) then value = 0.0000813332140446194 end
	if (si == 9) then value = 0.0000394689063955416 end
	if (si == 10) then value = 0.0000696496044482881 end
	if (si == 11) then value = 0.0000773008031921551 end
	if (si == 12) then value = 0.0000189560882216346 end
	if (si == 13) then value = 0.0000711419709171623 end
	if (si == 14) then value = 0.0000386666451851971 end
	if (si == 15) then value = 0.0000426816906217655 end
	if (si == 16) then value = 0.0000547880545183287 end
	if (si == 17) then value = 0.000121831485555802 end
	if (si == 18) then value = 0.000100314737488871 end
	if (si == 19) then value = 0.000175370175029905 end
	if (si == 20) then value = 0.000129886005928914 end
	if (si == 21) then value = 0.0000476816882683413 end
	if (si == 22) then value = 0.0000978984466779794 end
	if (si == 23) then value = 0.0000879529577323214 end
	if (si == 24) then value = 0.0000974115402444022 end
	if (si == 25) then value = 0.0000103354900055812 end
	if (si == 26) then value = 0.0000147596574283511 end
	
	return value
end

function InitialinSubsetsI(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.0000299862063450813 end
	if (si == 2) then value = 0.000104456304932825 end
	if (si == 3) then value = 0.0000590722284576241 end
	if (si == 4) then value = 0.0000447215762438987 end
	if (si == 5) then value = 0.0000249368267056789 end
	if (si == 6) then value = 0.0000556043638304734 end
	if (si == 7) then value = 0.00014922477728202 end
	if (si == 8) then value = 0.000101666517555774 end
	if (si == 9) then value = 0.0000670971408724207 end
	if (si == 10) then value = 0.0000986702729684081 end
	if (si == 11) then value = 0.0000957057563331444 end
	if (si == 12) then value = 0.0000568682646649038 end
	if (si == 13) then value = 0.000244254100148924 end
	if (si == 14) then value = 0.0000998888333950926 end
	if (si == 15) then value = 0.000117374649209855 end
	if (si == 16) then value = 0.000118005040501016 end
	if (si == 17) then value = 0.000408493804510632 end
	if (si == 18) then value = 0.000259146405179584 end
	if (si == 19) then value = 0.000291847380833349 end
	if (si == 20) then value = 0.000267412365147764 end
	if (si == 21) then value = 0.000227189220572685 end
	if (si == 22) then value = 0.000242933182497208 end
	if (si == 23) then value = 0.000169623561340906 end
	if (si == 24) then value = 0.000211618173634391 end
	if (si == 25) then value = 0.0000310064700167435 end
	if (si == 26) then value = 0.00026567383371032 end
	
	return value
end

function InitialinSubsetsR(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.00226895628011115 end
	if (si == 2) then value = 0.0024323396720072 end
	if (si == 3) then value = 0.00197891965333041 end
	if (si == 4) then value = 0.00136081367713577 end
	if (si == 5) then value = 0.00266824045750765 end
	if (si == 6) then value = 0.00330845964791317 end
	if (si == 7) then value = 0.00235277732181318 end
	if (si == 8) then value = 0.00113459833592244 end
	if (si == 9) then value = 0.00157875625582166 end
	if (si == 10) then value = 0.00219396254012107 end
	if (si == 11) then value = 0.00126257978547187 end
	if (si == 12) then value = 0.00145961879306586 end
	if (si == 13) then value = 0.00240222721796951 end
	if (si == 14) then value = 0.00153699914611159 end
	if (si == 15) then value = 0.0021660957990546 end
	if (si == 16) then value = 0.0014750630062627 end
	if (si == 17) then value = 0.0026444598923583 end
	if (si == 18) then value = 0.00214840729455333 end
	if (si == 19) then value = 0.00316844174438357 end
	if (si == 20) then value = 0.00321658873506311 end
	if (si == 21) then value = 0.00261688324437426 end
	if (si == 22) then value = 0.0027447823753789 end
	if (si == 23) then value = 0.00214856511031814 end
	if (si == 24) then value = 0.0017063814635916 end
	if (si == 25) then value = 0.00413419600223247 end
	if (si == 26) then value = 0.00175270931961669 end
	
	return value
end

function InitialinSubsetsD(posx, posy, t,si)
	value = 1.0
	if (si == 1) then value = 0.000159926433840433 end
	if (si == 2) then value = 0.0000447669878283534 end
	if (si == 3) then value = 0.000130802791584739 end
	if (si == 4) then value = 0.0000319439830313562 end
	if (si == 5) then value = 0.000191182338076872 end
	if (si == 6) then value = 0.000216857018938846 end
	if (si == 7) then value = 0.00007461238864101 end
	if (si == 8) then value = 0.0000162666428089239 end
	if (si == 9) then value = 0.0000789378127910832 end
	if (si == 10) then value = 0.000040628935928168 end
	if (si == 11) then value = 0.0000147239625127914 end
	if (si == 12) then value = 0.0000568682646649038 end
	if (si == 13) then value = 0.00012568414862032 end
	if (si == 14) then value = 0.0000418888656172969 end
	if (si == 15) then value = 0.0000426816906217655 end
	if (si == 16) then value = 0.0000252867943930748 end
	if (si == 17) then value = 0.00175222342461139 end
	if (si == 18) then value = 0.0000668764916592476 end
	if (si == 19) then value = 0.0000942287507623368 end
	if (si == 20) then value = 0.0000764035328993613 end
	if (si == 21) then value = 0.000126216233651492 end
	if (si == 22) then value = 0.0000543880259322108 end
	if (si == 23) then value = 0.00011308237422727 end
	if (si == 24) then value = 0.0000705393912114637 end
	if (si == 25) then value = 0.000651135870351613 end
	if (si == 26) then value = 0.0000110697430712633 end
	
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
