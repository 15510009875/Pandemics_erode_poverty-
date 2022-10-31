*******************figure2
set more off
cd D:\data\论文\COVID19_Poverty\data_dofile\data\
use working_data.dta,clear
reghdfe ELE pre_4 pre_3 pre_2  post* HDD CDD  WIND HUM RAIN ,absorb( c#mon c#newyear) vce(cluster cun)
parmest , saving(Parallel_trend_test_ALL.dta, replace) idstr("coef_ALL") idnum(1) 
reghdfe ELE pre_4 pre_3 pre_2  post* HDD CDD  WIND HUM RAIN  if department=="Commerce" ,absorb( c#mon c#newyear)  vce(cluster cun)
parmest , saving(Parallel_trend_test_Com.dta, replace) idstr("coef_Com") idnum(1) 
reghdfe ELE pre_4 pre_3 pre_2  post* HDD CDD  WIND HUM RAIN  if department=="Industry",absorb( c#mon c#newyear)  vce(cluster cun)
parmest , saving(Parallel_trend_test_Ind.dta, replace) idstr("coef_Ind") idnum(1) 
reghdfe ELE pre_4 pre_3 pre_2  post* HDD CDD  WIND HUM RAIN  if department=="Agriculture" ,absorb( c#mon c#newyear)  vce(cluster cun)
parmest , saving(Parallel_trend_test_Agr.dta, replace) idstr("coef_Agr") idnum(1) 

use Parallel_trend_test_ALL.dta,clear
keep if idnum == 1
		gen x = _n-4 
		drop if x>=8
		graph twoway (rarea max95 min95 x if x <= 7, fcolor(ebg) lcolor(ebg)) ///
		(line estimate x if x <= 0, lcolor(gs6) lpattern(solid)) ///
			(line estimate x if x >= 0 & x <= 4, lcolor(blue*1.2) lpattern(solid)) ///
			(line estimate x if x >= 4 & x <=6, lcolor(green*1.2) lpattern(shortdash)) ///
			(line estimate x if x >= 6 & x <= 7, lcolor(red*1.2) lpattern(solid)) ///
			(scatter estimate x if x <= -1, mcolor(gs6) mlcolor(gs6) msymbol(circle) msize(0.8)) ///
			(scatter estimate x if x >= 0 & x <= 3, mcolor(blue*1.2)  mlcolor(blue*1.2)   msymbol(circle) msize(0.8)) ///
			(scatter estimate x if x>= 4 & x <= 5,  mcolor(green*1.2) mlcolor(green*1.2)  msymbol(circle) msize(0.8)) ///
			(scatter estimate x if x>= 6 & x <= 7,  mcolor(red*1.2)   mlcolor(red*1.2)    msymbol(circle) msize(0.8)) ///
			,scheme(plotplain) ///
			xlab(-3 "{bf:-3}" -2 "{bf:-2}" -1 "{bf:-1}" 0 "{bf:1}" 1 "{bf:2}" 2 "{bf:3}" 3 "{bf:4}" 4 "{bf:5}" 5 "{bf:6}" 6 "{bf:7}" 7 "{bf:8}", labsize(*0.8) labcolor(black) axis(1) nogrid) ///
			xscale(range(-3.5 7.5)) ///
			ylabel(-2.0 "{bf:-2}" -1.0"{bf:-1}" -0.0"{bf:0}" 1"{bf:1}" 2"{bf:2}", labsize(*0.8) nogrid) ///
			yline(0,lp(shortdash) lcolor(gs3) lwidth(middle)) ///
			xline(0,lp(shortdash) lcolor(gs3) lwidth(middle)) ///
			title( "{bf:All}", pos(11) size(4)) ///
			xtitle("") ///
			ytitle("") ///
			graphregion(fcolor(white)) ///
			legend(order(7  8  9) label(7 "{bf:National outbreak (Jan-Apr)}") ///
			label(8 "{bf:Mitigation period (May-Jun)}") label(9 "{bf:Regional outbreak (Jul-Agu)}") size(3)  color(gs3) col(3) row(3) ring(0) pos(11) ///
			rowgap(0.4) colgap(0.4) keygap(0.4) region(lcolor(white)) ) 					
graph export "Parallel_trend_test_ALL.png",  as(png) replace		

use Parallel_trend_test_Com.dta,clear
keep if idnum == 1
		gen x = _n-4 
		drop if x>=8
		graph twoway (rarea max95 min95 x if x <= 7, fcolor(ebg) lcolor(ebg)) ///
		(line estimate x if x <= 0, lcolor(gs6) lpattern(solid)) ///
			(line estimate x if x >= 0 & x <= 4, lcolor(blue*1.2) lpattern(solid)) ///
			(line estimate x if x >= 4 & x <=6, lcolor(green*1.2) lpattern(shortdash)) ///
			(line estimate x if x >= 6 & x <= 7, lcolor(red*1.2) lpattern(solid)) ///
			(scatter estimate x if x <= -1, mcolor(gs6) mlcolor(gs6) msymbol(circle) msize(0.8)) ///
			(scatter estimate x if x >= 0 & x <= 3, mcolor(blue*1.2)  mlcolor(blue*1.2)   msymbol(circle) msize(0.8)) ///
			(scatter estimate x if x>= 4 & x <= 5,  mcolor(green*1.2) mlcolor(green*1.2)  msymbol(circle) msize(0.8)) ///
			(scatter estimate x if x>= 6 & x <= 7,  mcolor(red*1.2)   mlcolor(red*1.2)    msymbol(circle) msize(0.8)) ///
			,scheme(plotplain) ///
			xlab(-3 "{bf:-3}" -2 "{bf:-2}" -1 "{bf:-1}" 0 "{bf:1}" 1 "{bf:2}" 2 "{bf:3}" 3 "{bf:4}" 4 "{bf:5}" 5 "{bf:6}" 6 "{bf:7}" 7 "{bf:8}", labsize(*0.8) labcolor(black) axis(1) nogrid) ///
			xscale(range(-3.5 7.5)) ///
			ylabel(-2.0 "{bf:-2}" -1.0"{bf:-1}" -0.0"{bf:0}" 1"{bf:1}" 2"{bf:2}", labsize(*0.8) nogrid) ///
			yline(0,lp(shortdash) lcolor(gs3) lwidth(middle)) ///
			xline(0,lp(shortdash) lcolor(gs3) lwidth(middle)) ///
			title( "{bf:Commerce}", pos(11) size(4)) ///
			xtitle("") ///
			ytitle("") ///
			graphregion(fcolor(white)) ///
			legend(order(7  8 9) label(7 "{bf:National outbreak (Jan-Apr)}") ///
			label(8 "{bf:Mitigation period (May-Jun)}") label(9 "{bf:Regional outbreak (Jul-Agu)}") size(3)  color(gs3) col(3) row(3) ring(0) pos(11) ///
			rowgap(0.4) colgap(0.4) keygap(0.4) region(lcolor(white)) ) 					
graph export "Parallel_trend_test_Com.png",  as(png) replace		

use Parallel_trend_test_Ind.dta,clear
keep if idnum == 1
		gen x = _n-4 
		drop if x>=8
		graph twoway (rarea max95 min95 x if x <= 7, fcolor(ebg) lcolor(ebg)) ///
		(line estimate x if x <= 0, lcolor(gs6) lpattern(solid)) ///
			(line estimate x if x >= 0 & x <= 4, lcolor(blue*1.2) lpattern(solid)) ///
			(line estimate x if x >= 4 & x <=6, lcolor(green*1.2) lpattern(shortdash)) ///
			(line estimate x if x >= 6 & x <= 7, lcolor(red*1.2) lpattern(solid)) ///
			(scatter estimate x if x <= -1, mcolor(gs6) mlcolor(gs6) msymbol(circle) msize(0.8)) ///
			(scatter estimate x if x >= 0 & x <= 3, mcolor(blue*1.2)  mlcolor(blue*1.2)   msymbol(circle) msize(0.8)) ///
			(scatter estimate x if x>= 4 & x <= 5,  mcolor(green*1.2) mlcolor(green*1.2)  msymbol(circle) msize(0.8)) ///
			(scatter estimate x if x>= 6 & x <= 7,  mcolor(red*1.2)   mlcolor(red*1.2)    msymbol(circle) msize(0.8)) ///
			,scheme(plotplain) ///
			xlab(-3 "{bf:-3}" -2 "{bf:-2}" -1 "{bf:-1}" 0 "{bf:1}" 1 "{bf:2}" 2 "{bf:3}" 3 "{bf:4}" 4 "{bf:5}" 5 "{bf:6}" 6 "{bf:7}" 7 "{bf:8}", labsize(*0.8) labcolor(black) axis(1) nogrid) ///
			xscale(range(-3.5 7.5)) ///
			ylabel(-2.0 "{bf:-2}" -1.0"{bf:-1}" -0.0"{bf:0}" 1"{bf:1}" 2"{bf:2}", labsize(*0.8) nogrid) ///
			yline(0,lp(shortdash) lcolor(gs3) lwidth(middle)) ///
			xline(0,lp(shortdash) lcolor(gs3) lwidth(middle)) ///
			title( "{bf:Industry}", pos(11) size(4)) ///
			xtitle("") ///
			ytitle("") ///
			graphregion(fcolor(white)) ///
			legend(order(7  8  9) label(7 "{bf:National outbreak (Jan-Apr)}") ///
			label(8 "{bf:Mitigation period (May-Jun)}") label(9 "{bf:Regional outbreak (Jul-Agu)}") size(3)  color(gs3) col(3) row(3) ring(0) pos(11) ///
			rowgap(0.4) colgap(0.4) keygap(0.4) region(lcolor(white)) ) 					
graph export "Parallel_trend_test_Ind.png",  as(png) replace		

use Parallel_trend_test_Agr.dta,clear
keep if idnum == 1
		gen x = _n-4 
		drop if x>=8
graph twoway (rarea max95 min95 x if x <= 7, fcolor(ebg) lcolor(ebg)) ///
		(line estimate x if x <= 0, lcolor(gs6) lpattern(solid)) ///
			(line estimate x if x >= 0 & x <= 4, lcolor(blue*1.2) lpattern(solid)) ///
			(line estimate x if x >= 4 & x <=6, lcolor(green*1.2) lpattern(shortdash)) ///
			(line estimate x if x >= 6 & x <= 7, lcolor(red*1.2) lpattern(solid)) ///
			(scatter estimate x if x <= -1, mcolor(gs6) mlcolor(gs6) msymbol(circle) msize(0.8)) ///
			(scatter estimate x if x >= 0 & x <= 3, mcolor(blue*1.2)  mlcolor(blue*1.2)   msymbol(circle) msize(0.8)) ///
			(scatter estimate x if x>= 4 & x <= 5,  mcolor(green*1.2) mlcolor(green*1.2)  msymbol(circle) msize(0.8)) ///
			(scatter estimate x if x>= 6 & x <= 7,  mcolor(red*1.2)   mlcolor(red*1.2)    msymbol(circle) msize(0.8)) ///
			,scheme(plotplain) ///
			xlab(-3 "{bf:-3}" -2 "{bf:-2}" -1 "{bf:-1}" 0 "{bf:1}" 1 "{bf:2}" 2 "{bf:3}" 3 "{bf:4}" 4 "{bf:5}" 5 "{bf:6}" 6 "{bf:7}" 7 "{bf:8}", labsize(*0.8) labcolor(black) axis(1) nogrid) ///
			xscale(range(-3.5 7.5)) ///
			ylabel(-2.0 "{bf:-2}" -1.0"{bf:-1}" -0.0"{bf:0}" 1"{bf:1}" 2"{bf:2}", labsize(*0.8) nogrid) ///
			yline(0,lp(shortdash) lcolor(gs3) lwidth(middle)) ///
			xline(0,lp(shortdash) lcolor(gs3) lwidth(middle)) ///
			title( "{bf:Agriculture}", pos(11) size(4)) ///
			xtitle("") ///
			ytitle("") ///
			graphregion(fcolor(white)) ///
			legend(order(7  8  9) label(7 "{bf:National outbreak (Jan-Apr)}") ///
			label(8 "{bf:Mitigation period (May-Jun)}") label(9 "{bf:Regional outbreak (Jul-Agu)}") size(3)  color(gs3) col(3) row(3) ring(0) pos(11) ///
			rowgap(0.4) colgap(0.4) keygap(0.4) region(lcolor(white)) ) 					
graph export "Parallel_trend_test_Agr.png",  as(png) replace	

use working_data.dta,clear
gen first=1 if mon==2 
replace first=1 if mon==1
replace first=1 if mon==3
replace first=1 if mon==4
replace first=0 if first==.
replace first=1 if mon==.
gen  relieve=1 if mon==6
replace relieve=1 if mon==5
replace relieve=0 if relieve==.
gen second=1 if mon==8
replace second=1 if mon==7
replace second=0 if second==.
gen Nation_C=first*treat
gen Mitigation_C=relieve*treat
gen Region_C=second*treat
preserve
reghdfe ELE Nation_C Mitigation_C Region_C HDD CDD  WIND HUM RAIN ,absorb( c#mon c#newyear)  vce(cluster cun) 
parmest , saving(coef_1nall.dta, replace) idstr("1nall") idnum(1) 
restore
preserve
reghdfe ELE  Nation_C Mitigation_C Region_C HDD CDD  WIND HUM RAIN if department=="Commerce" ,absorb( c#mon c#newyear)  vce(cluster cun) 
parmest , saving(coef_Com.dta, replace) idstr("coef_Com") idnum(1) 
restore
preserve
reghdfe ELE  Nation_C Mitigation_C Region_C  HDD CDD  WIND HUM RAIN if department=="Industry",absorb( c#mon c#newyear)  vce(cluster cun)
parmest , saving(coef_Ind.dta, replace) idstr("coef_Ind") idnum(1) 
restore
preserve
reghdfe ELE  Nation_C Mitigation_C Region_C  HDD CDD  WIND HUM RAIN if department=="Agriculture" ,absorb( c#mon c#newyear)  vce(cluster cun) 
parmest , saving(coef_Agr.dta, replace) idstr("coef_Agr") idnum(1) 
restore

use coef_1nall.dta,clear
keep if idstr == "1nall"
		gen x = 1 if parm == "Nation_C"
		replace x = 2 if parm == "Mitigation_C"
		replace x = 3 if parm == "Region_C"
		
		graph twoway (rspike min95 max95 x if x == 1, msymbol(circle) lcolor(gs6) lwidth(med)) ///
				(scatter estimate x if x == 1, msymbol(circle) mcolor(blue) mlcolor(blue*0.6) mlwidth(thin) ) ///
				(rspike min95 max95 x if x == 2, msymbol(circle) lcolor(gs6) lwidth(med)) ///
				(scatter estimate x if x == 2, msymbol(circle) mcolor(green*0.6) mlcolor(green*0.6) mlwidth(thin) ) ///
				(rspike min95 max95 x if x == 3, msymbol(circle) lcolor(gs6) lwidth(med)) ///
				(scatter estimate x if x == 3, msymbol(circle) mcolor(red) mlcolor(red*0.6) mlwidth(thin) ) ///
				, title("{bf:All}", pos(11) size(4)) ///
				xlabel(0.5 " " 1 "{bf:National outbreak}" 2 "{bf:Mitigation period}"  3 "{bf:Regional outbreak}" 3.5 " ", nogrid) ///
				ylabel(-1.8 "{bf:-1.8}" -1.2 "{bf:-1.2}" -0.6 "{bf:-0.6}" 0 "{bf:0}" 0.6 "{bf:0.6}" 1.2 "{bf:1.2}", nogrid) ///
				xtitle("") ///
				yline(0, lp(shortdash) lcolor(gs3) lwidth(middle)) ///
				text(-0.44 1 "{bf:-0.246}", size(2.0) linegap(1)) ///
				text(-0.54 1 "{bf:(-0.318 -0.174)}", size(2.0) linegap(1)) ///
				text(-0.38 2 "{bf:-0.182}", size(2.0) linegap(1)) ///
				text(-0.48 2 "{bf:(-0.271 -0.092)}", size(2.0) linegap(1)) ///
				text(-0.72 3 "{bf:-0.520}", size(2.0) linegap(1)) ///
				text(-0.82 3 "{bf:(-0.628 -0.412)}", size(2.0) linegap(1)) ///
				legend(order(2 4 6) label(2 "{bf:National outbreak (Jan-Apr)}") label(4 "{bf:Mitigation period (May-Jun)}") label(6 "{bf:Regional outbreak (Jul-Agu)}") ring(0) pos(11) rowgap(0.4) colgap(0.4) cols(1) region(lcolor(white))) ///
				graphregion(fcolor(white)) ///
				scheme(plotplain)
graph export "ALL_there_period.png",  as(png) replace


use  coef_Com.dta,clear
keep if idstr == "coef_Com"
		gen x = 1 if parm == "Nation_C"
		replace x = 2 if parm == "Mitigation_C"
		replace x = 3 if parm == "Region_C"
		
		graph twoway (rspike min95 max95 x if x == 1, msymbol(circle) lcolor(gs6) lwidth(med)) ///
				(scatter estimate x if x == 1, msymbol(circle) mcolor(blue) mlcolor(blue*0.6) mlwidth(thin) ) ///
				(rspike min95 max95 x if x == 2, msymbol(circle) lcolor(gs6) lwidth(med)) ///
				(scatter estimate x if x == 2, msymbol(circle) mcolor(green*0.6) mlcolor(green*0.6) mlwidth(thin) ) ///
				(rspike min95 max95 x if x == 3, msymbol(circle) lcolor(gs6) lwidth(med)) ///
				(scatter estimate x if x == 3, msymbol(circle) mcolor(red) mlcolor(red*0.6) mlwidth(thin) ) ///
				, title("{bf:Commerce}", pos(11) size(4)) ///
				xlabel(0.5 " " 1 "{bf:National outbreak}" 2 "{bf:Mitigation period}"  3 "{bf:Regional outbreak}" 3.5 " ", nogrid) ///
				ylabel(-1.8 "{bf:-1.8}" -1.2 "{bf:-1.2}" -0.6 "{bf:-0.6}" 0 "{bf:0}" 0.6 "{bf:0.6}" 1.2 "{bf:1.2}", nogrid) ///
				xtitle("") ///
				yline(0, lp(shortdash) lcolor(gs3) lwidth(middle)) ///
				text(-0.55 1 "{bf:-0.355}", size(2.0) linegap(1)) ///
				text(-0.65 1 "{bf:(-0.446 -0.264)}", size(2.0) linegap(1)) ///
				text(-0.42 2 "{bf:-0.218}", size(2.0) linegap(1)) ///
				text(-0.52 2 "{bf:(-0.345 -0.091)}", size(2.0) linegap(1)) ///
				text(-0.87 3 "{bf:-0.668}", size(2.0) linegap(1)) ///
				text(-0.97 3 "{bf:(-0.814 -0.522)}", size(2.0) linegap(1)) ///
				legend(order(2 4 6) label(2 "{bf:National outbreak (Jan-Apr)}") label(4 "{bf:Mitigation period (May-Jun)}") label(6 "{bf:Regional outbreak (Jul-Agu)}") ring(0) pos(11) rowgap(0.4) colgap(0.4) cols(1) region(lcolor(white))) ///
			    graphregion(fcolor(white)) ///
				scheme(plotplain)
graph export "Com_there_period.png",  as(png) replace	

use coef_Ind.dta,clear
keep if idstr == "coef_Ind"
		gen x = 1 if parm == "Nation_C"
		replace x = 2 if parm == "Mitigation_C"
		replace x = 3 if parm == "Region_C"
		
		graph twoway (rspike min95 max95 x if x == 1, msymbol(circle) lcolor(gs6) lwidth(med)) ///
				(scatter estimate x if x == 1, msymbol(circle) mcolor(blue) mlcolor(blue*0.6) mlwidth(thin) ) ///
				(rspike min95 max95 x if x == 2, msymbol(circle) lcolor(gs6) lwidth(med)) ///
				(scatter estimate x if x == 2, msymbol(circle) mcolor(green*0.6) mlcolor(green*0.6) mlwidth(thin) ) ///
				(rspike min95 max95 x if x == 3, msymbol(circle) lcolor(gs6) lwidth(med)) ///
				(scatter estimate x if x == 3, msymbol(circle) mcolor(red) mlcolor(red*0.6) mlwidth(thin) ) ///
				, title("{bf:Industy}", pos(11) size(4)) ///
				xlabel(0.5 " " 1 "{bf:National outbreak}" 2 "{bf:Mitigation period}"  3 "{bf:Regional outbreak}" 3.5 " ", nogrid) ///
				ylabel(-1.8 "{bf:-1.8}" -1.2 "{bf:-1.2}" -0.6 "{bf:-0.6}" 0 "{bf:0}" 0.6 "{bf:0.6}" 1.2 "{bf:1.2}", nogrid) ///
				xtitle("") ///
				yline(0, lp(shortdash) lcolor(gs3) lwidth(middle)) ///
				text(-0.33 1 "{bf:-0.134}", size(2.0) linegap(1)) ///
				text(-0.43 1 "{bf:(-0.251 -0.017)}", size(2.0) linegap(1)) ///
				text(-0.38 2 "{bf:-0.159}", size(2.0) linegap(1)) ///
				text(-0.48 2 "{bf:(-0.317 -0.001)}", size(2.0) linegap(1)) ///
				text(-0.68 3 "{bf:-0.432}", size(2.0) linegap(1)) ///
				text(-0.78 3 "{bf:(-0.599 -0.266)}", size(2.0) linegap(1)) ///
				legend(order(2 4 6) label(2 "{bf:National outbreak (Jan-Apr)}") label(4 "{bf:Mitigation period (May-Jun)}") label(6 "{bf:Regional outbreak (Jul-Agu)}") ring(0) pos(11) rowgap(0.4) colgap(0.4) cols(1) region(lcolor(white))) ///
				graphregion(fcolor(white)) ///
				scheme(plotplain)
graph export "Ind_there_period.png",  as(png) replace			
	
	
use coef_Agr.dta,clear
keep if idstr == "coef_Agr"
		gen x = 1 if parm == "Nation_C"
		replace x = 2 if parm == "Mitigation_C"
		replace x = 3 if parm == "Region_C"
		
		graph twoway (rspike min95 max95 x if x == 1, msymbol(circle) lcolor(gs6) lwidth(med)) ///
				(scatter estimate x if x == 1, msymbol(circle) mcolor(blue) mlcolor(blue*0.6) mlwidth(thin) ) ///
				(rspike min95 max95 x if x == 2, msymbol(circle) lcolor(gs6) lwidth(med)) ///
				(scatter estimate x if x == 2, msymbol(circle) mcolor(green*0.6) mlcolor(green*0.6) mlwidth(thin) ) ///
				(rspike min95 max95 x if x == 3, msymbol(circle) lcolor(gs6) lwidth(med)) ///
				(scatter estimate x if x == 3, msymbol(circle) mcolor(red) mlcolor(red*0.6) mlwidth(thin) ) ///
				, title("{bf:Agriculture}", pos(11) size(4)) ///
				xlabel(0.5 " " 1 "{bf:National outbreak}" 2 "{bf:Mitigation period}"  3 "{bf:Regional outbreak}" 3.5 " ", nogrid) ///
				ylabel(-1.8 "{bf:-1.8}" -1.2 "{bf:-1.2}" -0.6 "{bf:-0.6}" 0 "{bf:0}" 0.6 "{bf:0.6}" 1.2 "{bf:1.2}", nogrid) ///
				xtitle("") ///
				yline(0, lp(shortdash) lcolor(gs3) lwidth(middle)) ///
				text(-0.29 1 "{bf:-0.092}", size(2.0) linegap(1)) ///
				text(-0.39 1 "{bf:(-0.245 0.060)}", size(2.0) linegap(1)) ///
				text(-0.42 2 "{bf:-0.016}", size(2.0) linegap(1)) ///
				text(-0.52 2 "{bf:(-0.323 0.291)}", size(2.0) linegap(1)) ///
				text(-0.41 3 "{bf:-0.024}", size(2.0) linegap(1)) ///
				text(-0.51 3 "{bf:(-0.313 0.362)}", size(2.0) linegap(1)) ///
				legend(order(2 4 6) label(2 "{bf:National outbreak (Jan-Apr)}") label(4 "{bf:Mitigation period (May-Jun)}") label(6 "{bf:Regional outbreak (Jul-Agu)}") ring(0) pos(11) rowgap(0.4) colgap(0.4) cols(1) region(lcolor(white))) ///
				graphregion(fcolor(white)) ///
				scheme(plotplain)
graph export "Agr_there_period.png.png",  as(png) replace




*****************figure 3
use working_data.dta,clear
keep if  department=="Commerce"	
reghdfe ELE DID HDD CDD  WIND HUM RAIN ,absorb( c#mon c#newyear , savefe) vce(cluster cun)
keep if e(sample)==1
predictnl yhat_ln = xb() + __hdfe1__  + __hdfe2__+_b[HDD]*HDD +_b[CDD]*CDD+_b[WIND]*WIND+_b[HUM]*HUM+_b[RAIN]*RAIN
predictnl yhat_cf_ln = xb() - _b[DID]*DID + __hdfe1__  + __hdfe2__+_b[HDD]*HDD +_b[CDD]*CDD+_b[WIND]*WIND+_b[HUM]*HUM+_b[RAIN]*RAIN
collapse (mean) ELE yhat_ln yhat_cf_ln, by(date)	
sort date
gen ym=_n
graph twoway (line ELE ym, lcolor(edkblue) lpattern(soild) lwidth(medthick ))(line yhat_cf_ln ym, lpattern(shortdash) lcolor(gs6)  lwidth(medthick )) ///
				, legend(order(1 2) col(1) label(1 "{bf:Real}") label(2 "{bf:Counterfactual}") ring(0) pos(10) rowgap(0.4) colgap(0.4) region(lcolor(white)) size(4.0)) ///
				xlab(1 "{bf:16-Sep}" 12 "{bf:17-Agu}" 24 "{bf:18-Agu}" 36 "{bf:19-Agu}" 48 "{bf:20-Agu}", labsize(*1) labcolor(black) axis(1) nogrid) ///
				xscale(range(-3 10)) ///
				ylabel(0 "{bf:0}" 2"{bf:2}" 4 "{bf:4}" 6 "        .", nogrid) ///
				xtitle("") ytitle("") ///
				title("{bf:Commerce}", size(5) pos(11) ring(1)) ///
				xline(41, lp(dash) lcolor(ebg*2) lwidth(middle)) ///
				text(6 46 "{bf:COVID-19}", size(4.0) linegap(0) color(gs0*2) ) ///
				graphregion(fcolor(white)) ///
				scheme(plotplain)
rename yhat_cf_ln Com_yhat_cf_ln
keep  Com_yhat_cf_ln ym
save "Com_mean.dta",replace
graph export "Predict_Com.png",  as(png) replace	

use working_data.dta,clear
keep if  department=="Industry"	
reghdfe ELE DID HDD CDD  WIND HUM RAIN ,absorb( c#mon c#newyear , savefe) vce(cluster cun)
predictnl yhat_ln = xb() + __hdfe1__  + __hdfe2__+_b[HDD]*HDD +_b[CDD]*CDD+_b[WIND]*WIND+_b[HUM]*HUM+_b[RAIN]*RAIN
predictnl yhat_cf_ln = xb() - _b[DID]*DID + __hdfe1__  + __hdfe2__+_b[HDD]*HDD +_b[CDD]*CDD+_b[WIND]*WIND+_b[HUM]*HUM+_b[RAIN]*RAIN
collapse (mean) ELE yhat_ln yhat_cf_ln, by(date)	
sort date
gen ym=_n
graph twoway (line ELE ym, lcolor(edkblue) lpattern(soild) lwidth(medthick ))(line yhat_cf_ln ym, lpattern(shortdash) lcolor(gs6)  lwidth(medthick )) ///
				, legend(order(1 2) col(1) label(1 "{bf:Real}") label(2 "{bf:Counterfactual}") ring(0) pos(10) rowgap(0.4) colgap(0.4) region(lcolor(white)) size(4.0)) ///
				xlab(1 "{bf:16-Sep}" 12 "{bf:17-Agu}" 24 "{bf:18-Agu}" 36 "{bf:19-Agu}" 48 "{bf:20-Agu}", labsize(*1) labcolor(black) axis(1) nogrid) ///
				xscale(range(-3 10)) ///
				ylabel(0 "{bf:0}" 2"{bf:2}" 4 "{bf:4}" 6 "        .", nogrid) ///
				xtitle("") ytitle("") ///
				title("{bf:Industry}", size(5) pos(11) ring(1)) ///
				xline(41, lp(dash) lcolor(ebg*2) lwidth(middle)) ///
				text(6 46 "{bf:COVID-19}", size(4.0) linegap(0) color(gs0*2) ) ///
				graphregion(fcolor(white)) ///
				scheme(plotplain)
rename yhat_cf_ln Ind_yhat_cf_ln
keep  Ind_yhat_cf_ln ym
save "Ind_mean.dta",replace
graph export "Predict_Ind.png",  as(png) replace	

use working_data.dta,clear
keep if department=="Agriculture" 
reghdfe ELE DID HDD CDD  WIND HUM RAIN ,absorb( c#mon c#newyear , savefe) vce(cluster cun)
predictnl yhat_ln = xb() + __hdfe1__  + __hdfe2__-_b[HDD]*HDD +_b[CDD]*CDD+_b[WIND]*WIND+_b[HUM]*HUM+_b[RAIN]*RAIN
predictnl yhat_cf_ln = xb() - _b[DID]*DID + __hdfe1__  + __hdfe2__+_b[HDD]*HDD +_b[CDD]*CDD+_b[WIND]*WIND+_b[HUM]*HUM+_b[RAIN]*RAIN
collapse (mean) ELE yhat_ln yhat_cf_ln, by(date)	
sort date
gen ym=_n
graph twoway (line ELE ym, lcolor(edkblue) lpattern(soild) lwidth(medthick ))(line yhat_cf_ln ym, lpattern(shortdash) lcolor(gs6)  lwidth(medthick )) ///
				, legend(order(1 2) col(1) label(1 "{bf:Real}") label(2 "{bf:Counterfactual}") ring(0) pos(10) rowgap(0.4) colgap(0.4) region(lcolor(white)) size(4.0)) ///
				xlab(1 "{bf:16-Sep}" 12 "{bf:17-Agu}" 24 "{bf:18-Agu}" 36 "{bf:19-Agu}" 48 "{bf:20-Agu}", labsize(*1) labcolor(black) axis(1) nogrid) ///
				xscale(range(-3 10)) ///
				ylabel(0 "{bf:0}" 2"{bf:2}" 4 "{bf:4}" 6 "        .", nogrid) ///
				xtitle("") ytitle("") ///
				title("{bf:Agriculture}", size(5) pos(11) ring(1)) ///
				xline(41, lp(dash) lcolor(ebg*2) lwidth(middle)) ///
				text(6 46 "{bf:COVID-19}", size(4.0) linegap(0) color(gs0*2) ) ///
				graphregion(fcolor(white)) ///
				scheme(plotplain)
rename yhat_cf_ln Agr_yhat_cf_ln
keep  Agr_yhat_cf_ln ym
save "Agr_mean.dta",replace
graph export "Predict_Agr.png",  as(png) replace	



use working_data.dta,clear
gen hu=1
bys department ym:egen sumhu=sum(hu)
bys ym:egen sum=sum(hu)
gen bi=sumhu/sum
keep if department=="Commerce"
egen z=tag(ym)
drop if z==0
sort ym
drop ym 
rename date ym
keep bi ym
rename bi Com_bi
save "Com_bi.dta",replace
use working_data.dta,clear
gen hu=1
bys department ym:egen sumhu=sum(hu)
bys ym:egen sum=sum(hu)
gen bi=sumhu/sum
keep if department=="Industry"
egen z=tag(ym)
drop if z==0
sort ym
drop ym 
rename date ym
keep bi ym
rename bi Ind_bi
save "Ind_bi.dta",replace
use working_data.dta,clear
gen hu=1
bys department ym:egen sumhu=sum(hu)
bys ym:egen sum=sum(hu)
gen bi=sumhu/sum
keep if department=="Agriculture"
egen z=tag(ym)
drop if z==0
sort ym
drop ym 
rename date ym
keep bi ym
rename bi Agr_bi 
save "Agr_bi.dta",replace
use working_data.dta,clear
collapse (mean) ELE , by(date)
rename date ym
keep ELE ym
save "All_mean.dta",replace

set more off
use "Agr_mean.dta",clear
merge 1:1 ym using "All_mean.dta"
drop _merge
merge 1:1 ym using "Ind_mean.dta"
drop _merge
merge 1:1 ym using "Com_mean.dta"
drop _merge
merge 1:1 ym using "Agr_bi.dta"
drop _merge
merge 1:1 ym using "Com_bi.dta"
drop _merge
merge 1:1 ym using "Ind_bi.dta"
drop _merge
gen predict_all=Agr_yhat_cf_ln* Agr_bi+ Ind_bi* Ind_yhat_cf_ln+ Com_yhat_cf_ln *Com_bi 
graph twoway (line ELE ym, lcolor(edkblue) lpattern(soild) lwidth(medthick ))(line predict_all ym, lpattern(shortdash) lcolor(gs6)  lwidth(medthick )) ///
				, legend(order(1 2) col(1) label(1 "{bf:Real}") label(2 "{bf:Counterfactual}") ring(0) pos(10) rowgap(0.4) colgap(0.4) region(lcolor(white)) size(4.0)) ///
				xlab(1 "{bf:16-Sep}" 12 "{bf:17-Agu}" 24 "{bf:18-Agu}" 36 "{bf:19-Agu}" 48 "{bf:20-Agu}", labsize(*1) labcolor(black) axis(1) nogrid) ///
				xscale(range(-3 10)) ///
				ylabel(0 "{bf:0}" 2"{bf:2}" 4 "{bf:4}" 6 "        .", nogrid) ///
				xtitle("") ytitle("") ///
				title("{bf:All}", size(5) pos(11) ring(1)) ///
				xline(41, lp(dash) lcolor(ebg*2) lwidth(middle)) ///
				text(6 46 "{bf:COVID-19}", size(4.0) linegap(0) color(gs0*2) ) ///
				graphregion(fcolor(white)) ///
				scheme(plotplain)
graph export "Predict_all.png",  as(png) replace


************************SI figure 1
use "covid.dta",clear
graph twoway (area Regional id, fcolor(ebg) lcolor(ebg) yaxis(1)) /// 
                    (line Regional id, lpattern(shortdash) lcolor(ebg) lwidth(thin) yaxis(1)) ///
					(line National id, lpattern(shortdash) lcolor(gs6) lwidth(thin) yaxis(2)) ///
					, legend(order(1 3) label(1 "Regional existing confirmed cases")	///
					   label(3 "National existing confirmed cases") ring(0) pos(11) rowgap(0.6) cols(1) region(lcolor(white))) ///
					ylabel(1000 600 200 100 0 0.00000000000001 "          .", nogrid axis(1)) ///
					ylabel(80000 60000 40000 20000   0 0.00000000000001 "          .", nogrid axis(2)) ///
					xlabel(1 " "  123 "Jan" 154 "Feb" 183 "Mar" 214 "Apr" 244 "May" 305 "Jul" 336 "Aug"  366 "Sep", nogrid) ///
					xscale(range(1 365)) ///
					title("Trend of COVID-19 cases", size(4) pos(11) ring(2)) ///
					text(770 170 "National" "outbreak", size(2.2)) ///
					text(700 341 "Regional" "outbreak", size(2.2)) ///
					ytitle("" ,axis(1)) ///
					ytitle("" ,axis(2)) ///
					xtitle("") ///
					graphregion(fcolor(white)) ///
					scheme(plotplain) 
******************************SI figure 2
use "Poverty_covid.dta",clear
merge 1:1 c using "Poverty_electricity.dta"
keep if _merge==3
drop _merge
gen D_P_COVID=sum_covid-sum_poverty
gen f=1 if D_P_COVID<0
replace f=0 if f==.
tab f
bys department: tab f
sum D_P_COVID,detail
replace D_P_COVID=-4281 if D_P_COVID<=-4281
replace D_P_COVID=4281 if D_P_COVID>=4281
twoway(histogram D_P_COVID, percent bin(20) color(green*0.5) ///
fcolor(ebg) lcolor(gs11) yaxis(1)), ///
graphregion(fcolor(white)) ///
scheme(plotplain) ///
xtitle("D_P_COVID") ///
ytitle("Percentage") ///
text(20 -1400 "51.11% ——> ", size(4) linegap(1))  ///
text(18 -2400 "Return to poverty from the electricty", size(3) linegap(1)) ///
xline(0,lp(soild) lcolor(gs0) ) 
graph export "Return_poverty.png",  as(png) replace	
***************************SI figure 3
use working_data.dta,clear
keep c mon newyear ELE HDD CDD  WIND HUM RAIN  date cun
xtset c date

		forvalues i = 1(1)1000{
			quietly bys c: gen num`i' = runiform() if newyear <= 2020 & mon == 2
			quietly bys c: egen rank`i' = rank(num`i')
			
			quietly gen r_DID`i' = 0
			quietly replace r_DID`i' = 1 if rank`i' == 1
		
			quietly replace r_DID`i' = l2.r_DID`i' if mon == 3
			quietly replace r_DID`i' = l3.r_DID`i' if mon == 4
			quietly replace r_DID`i' = l4.r_DID`i' if mon == 5
			quietly replace r_DID`i' = l5.r_DID`i' if mon == 6
			quietly replace r_DID`i' = l6.r_DID`i' if mon == 7
			quietly replace r_DID`i' = l7.r_DID`i' if mon == 8
			quietly replace r_DID`i' = l7.r_DID`i' if mon == 9
			}
		
			drop num* rank*
			
save "placebo_random.dta", replace 
		
use "placebo_random.dta", clear 
						
		drop if newyear == 2020
		gen base = 0
				
		forvalues i = 1(1)100{
			quietly reghdfe ELE r_DID`i' HDD CDD  WIND HUM RAIN  ,absorb( c#mon c#newyear) vce(cluster cun)
			quietly lincom r_DID`i'
			quietly generate placebo_DID`i' = r(estimate) 
		}
		
			
	* keep estimate
		
		keep placebo* 
		
		gen sample = _n
		keep if sample == 1
		
		reshape long placebo_DID , i(sample) j(x)
		drop sample 
		
save "placebo_month.dta", replace 	

	
use "placebo_month.dta",clear
gen DID=-.2878
twoway (kdensity placebo_DID) (kdensity DID) ,xline(-0.2878,lp(shortdash) lcolor(gs10) lwidth(vthin)) ///
graphregion(fcolor(white)) legend(off) xtitle("") ///
scheme(plotplain)					
graph export "placebo_test.png", as(png) replace
