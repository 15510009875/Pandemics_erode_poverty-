set more off
cd D:\data\论文\COVID19_Poverty\data_dofile\data\
use working_data.dta,clear
keep if department=="Agriculture" 
reghdfe ELE DID HDD CDD  WIND HUM RAIN ,absorb( c#mon c#newyear , savefe) vce(cluster cun)
keep if e(sample)==1
predictnl yhat_ln = xb() + __hdfe1__  + __hdfe2__-_b[HDD]*HDD +_b[CDD]*CDD+_b[WIND]*WIND+_b[HUM]*HUM+_b[RAIN]*RAIN
predictnl yhat_cf_ln = xb() - _b[DID]*DID + __hdfe1__  + __hdfe2__+_b[HDD]*HDD +_b[CDD]*CDD+_b[WIND]*WIND+_b[HUM]*HUM+_b[RAIN]*RAIN
*drop if yhat_cf_ln<0
gen predict_Agr=exp(yhat_ln)
keep if newyear==2020
gen h=1
bys c: egen sum=sum(h)
keep if sum==12
gen cha_Agr=predict_Agr-electricity
bys c:egen sum_Agr =sum(cha_Agr)
egen z=tag(c)
drop if z==0
keep c sum_Agr
save "Agr_predict.dta",replace


use working_data.dta,clear
keep if  department=="Industry"	
reghdfe ELE DID HDD CDD  WIND HUM RAIN ,absorb( c#mon c#newyear , savefe) vce(cluster cun)
keep if e(sample)==1
predictnl yhat_ln = xb() + __hdfe1__  + __hdfe2__+_b[HDD]*HDD +_b[CDD]*CDD+_b[WIND]*WIND+_b[HUM]*HUM+_b[RAIN]*RAIN
predictnl yhat_cf_ln = xb() - _b[DID]*DID + __hdfe1__  + __hdfe2__+_b[HDD]*HDD +_b[CDD]*CDD+_b[WIND]*WIND+_b[HUM]*HUM+_b[RAIN]*RAIN
*drop if yhat_cf_ln<0
gen predict_Ind=exp(yhat_ln)
keep if newyear==2020
gen cha_Ind=predict_Ind-electricity
gen h=1
bys c: egen sum=sum(h)
keep if sum==12
bys c:egen sum_Ind =sum(cha_Ind)
egen z=tag(c)
drop if z==0
keep c sum_Ind
save "Ind_predict.dta",replace

use working_data.dta,clear
keep if  department=="Commerce"	
reghdfe ELE DID HDD CDD  WIND HUM RAIN ,absorb( c#mon c#newyear , savefe) vce(cluster cun)
keep if e(sample)==1
predictnl yhat_ln = xb() + __hdfe1__  + __hdfe2__+_b[HDD]*HDD +_b[CDD]*CDD+_b[WIND]*WIND+_b[HUM]*HUM+_b[RAIN]*RAIN
predictnl yhat_cf_ln = xb() - _b[DID]*DID + __hdfe1__  + __hdfe2__+_b[HDD]*HDD +_b[CDD]*CDD+_b[WIND]*WIND+_b[HUM]*HUM+_b[RAIN]*RAIN
*drop if yhat_cf_ln<0
gen predict_Com=exp(yhat_ln)
keep if newyear==2020
gen h=1
bys c: egen sum=sum(h)
keep if sum==12
gen cha_Com=predict_Com-electricity
bys c:egen sum_Com =sum(cha_Com)
egen z=tag(c)
drop if z==0
keep c sum_Com
save "Com_predict.dta",replace

use "Poverty_2019.dta",clear
merge m:1 c using "Com_predict.dta"
drop _merge
merge m:1 c using "Ind_predict.dta"
drop _merge
merge m:1 c using "Agr_predict.dta"
drop _merge
gen Inc_C=sum_Com*IE 
replace Inc_C =sum_Ind*IE if Inc_C==.
replace  Inc_C =sum_Agr*IE if Inc_C==.
drop if Inc_C ==.
gen I=(Income+Inc_C)
drop if Inc_C <-Income
replace Inc_C=-Productive_i if Inc_C <-Productive_i
gen Inc_Covid=(Income+Inc_C)/Number
gen R_Poverty=1 if Inc_Covid<=5000
replace R_Poverty=0 if R_Poverty==.
tab R_Poverty
bys department:tab R_Poverty
gen i= Inc_C/ Income
sum i






