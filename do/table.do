cd D:\data\论文\COVID19_Poverty\data_dofile\data\

********************************Table 1
use working_data.dta,clear
reghdfe ELE DID ,absorb( c#mon c#newyear) vce(cluster c)
est store m1
reghdfe ELE DID HDD CDD  WIND HUM RAIN  ,absorb( c#mon c#newyear) vce(cluster c)
est store m2
reghdfe ELE DID HDD CDD  WIND HUM RAIN  ,absorb( c#mon c#newyear) vce(cluster cun)
est store m3
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
reghdfe ELE  Nation_C Mitigation_C Region_C  HDD CDD  WIND HUM RAIN ,absorb( c#mon c#newyear)  vce(cluster cun) 
est store m4
esttab m1 m2 m3 m4 using Table1.csv, pr2 se replace nogap b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
***********************Table 2
set more off
use working_data.dta,clear
reghdfe ELE DID HDD CDD  WIND HUM RAIN  if department=="Commerce" ,absorb( c#mon c#newyear) vce(cluster cun)
est store m1
reghdfe ELE DID HDD CDD  WIND HUM RAIN  if department=="Industry" ,absorb( c#mon c#newyear) vce(cluster cun)
est store m2
reghdfe ELE DID HDD CDD  WIND HUM RAIN  if department=="Agriculture",absorb( c#mon c#newyear) vce(cluster cun)
est store m3
esttab m1 m2 m3 using Table2.csv, pr2 se replace nogap b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
***********************Figure 3A-D
set more off
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
reghdfe ELE Nation_C Mitigation_C Region_C HDD CDD  WIND HUM RAIN ,absorb( c#mon c#newyear)  vce(cluster cun) 
est store m1
reghdfe ELE  Nation_C Mitigation_C Region_C HDD CDD  WIND HUM RAIN  if department=="Commerce" ,absorb( c#mon c#newyear)  vce(cluster cun) 
est store m2
reghdfe ELE  Nation_C Mitigation_C Region_C  HDD CDD  WIND HUM RAIN   if department=="Industry",absorb( c#mon c#newyear)  vce(cluster cun)
est store m3
reghdfe ELE  Nation_C Mitigation_C Region_C  HDD CDD  WIND HUM RAIN  if department=="Agriculture" ,absorb( c#mon c#newyear)  vce(cluster cun)  
est store m4
esttab m1 m2 m3 m4  using Three_period.csv, pr2 se replace nogap b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
********************Figure 3E-H
set more off
use working_data.dta,clear
reghdfe ELE pre_4 pre_3 pre_2  post* HDD CDD  WIND HUM RAIN ,absorb( c#mon c#newyear) vce(cluster cun)
est store m1
reghdfe ELE pre_4 pre_3 pre_2  post* HDD CDD  WIND HUM RAIN  if department=="Commerce" ,absorb( c#mon c#newyear)  vce(cluster cun)
est store m2
reghdfe ELE pre_4 pre_3 pre_2  post* HDD CDD  WIND HUM RAIN  if department=="Industry",absorb( c#mon c#newyear)  vce(cluster cun)
est store m3
reghdfe ELE pre_4 pre_3 pre_2  post* HDD CDD  WIND HUM RAIN  if department=="Agriculture" ,absorb( c#mon c#newyear)  vce(cluster cun)
est store m4
esttab m1 m2 m3 m4 using Parallel_trend_test.csv, pr2 se replace nogap b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
******************************Table 3
set more off
use working_data.dta,clear
gen DID_Low_inc =DID*lowincome
reghdfe ELE DID  DID_Low_inc HDD CDD  WIND HUM RAIN if department=="Industry",absorb( c#mon c#newyear) vce(cluster cun)
est store m1
gen lowedu=1 if edumax<4
replace lowedu=0 if lowedu==.
gen DID_Low_edu=DID*lowedu
reghdfe ELE DID  DID_Low_edu HDD CDD  WIND HUM RAIN if department=="Industry" ,absorb( c#mon c#newyear) vce(cluster cun)
est store m2
gen  lowlab=1 if laborsum<2
replace lowlab=0 if lowlab==.
gen DID_Low_lab=DID*lowlab
reghdfe ELE DID DID_Low_lab HDD CDD  WIND HUM RAIN  if department=="Agriculture",absorb( c#mon c#newyear) vce(cluster cun)
est store m3
esttab m1 m2 m3  using  Heterogeneity.csv, pr2 se replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)
******************************Table 4
set more off
use working_data.dta,clear
gen DID_P_A_project=DID*Helping_Planting
reghdfe ELE DID DID_P_A_project HDD CDD  WIND HUM RAIN  if Purpose=="Planting" & department=="Agriculture" ,absorb( c#mon c#newyear) vce(cluster cun)
est store m1
drop DID_P_A_project
gen DID_P_A_project=DID*Helping_Breeding
reghdfe ELE DID  DID_P_A_project  HDD CDD  WIND HUM RAIN if Purpose=="Breeding" & department=="Agriculture" ,absorb( c#mon c#newyear) vce(cluster cun)
est store m2
drop DID_P_A_project
gen DID_P_A_project=DID*Helping_Process_ind 
reghdfe ELE DID  DID_P_A_project  HDD CDD  WIND HUM RAIN if Purpose=="Industry"  & department=="Industry" ,absorb( c#mon c#newyear) vce(cluster cun)
est store m3
drop DID_P_A_project
gen DID_P_A_project=DID*Helping_Rural_com
reghdfe ELE DID  DID_P_A_project  HDD CDD  WIND HUM RAIN  if Purpose=="Commerce" & department=="Commerce" ,absorb( c#mon c#newyear) vce(cluster cun)
est store m4
gen DID_Loan=DID*Loan
reghdfe ELE DID  DID_Loan HDD CDD  WIND HUM RAIN ,absorb( c#mon c#newyear) vce(cluster cun)
est store m5
gen DID_T_pay=DID*Trans_payments
reghdfe ELE DID  DID_T_pay  HDD CDD  WIND HUM RAIN ,absorb( c#mon c#newyear) vce(cluster cun)
est store m6
esttab m1 m2 m3 m4 m5 m6 using  Mitigation_measures.csv, pr2 se replace nogap  b(%9.4f) star(* 0.10 ** 0.05 *** 0.01)


