/*	****************************************************************
File Name:		generate ideodistgov6099 and malideodistgov6099.do				
Date:   		May 08, 2018								
Purpose:		this file generates variables ideodistgov6099 and 
				malideodistgov6099 of  Cruz Aceves and Mallinson (2018): 
				"Standardizing the Measurement of Relative Ideology in Policy 
				Diffusion Research" 		
Input Files:	b&b90.dta				
Output File:	b&b90temp.dta 
Version:		Stata 13
		
Instructions: 	1. Execute full syntax to generate variables ideodistgov6099 and 
				malideodistgov6099, and data set b&b90temp.dta
				2. Execute ideology_relative_berry.r in R (to generate variable
				ideology_relative_berry)
				3. Execute analysis.do in Stata (to generate Tables 1 & 2 of the
				publication)
	****************************************************************	*/
use "b&b90.dta", clear
qui{ 
keep if adopt==1							/* data management to generate */
sort year									/* variables ideodistgov6099 and */	
gen id=stnum								/* malideodistgov6099, and temporaty */
isid year id, sort 							/* dataset b&b90temp.dta, necessary */
by year: egen mfygov6099 = mean(gov6099) 	/* for ideology_relative_berry.r and */
by year: gen mfy1gov6099 = mfygov6099 if _n == 1	/* analysis.do */
drop if mi(mfy1gov6099)						
scalar N = _N 					 		 
gen gap = year - year[_n-1] 
expand gap
gen orig = _n <= scalar(N) 
replace mfy1gov6099=. if orig==0
sort year orig
replace year = year[_n-1] + 1 if _n > 1 & year != year[_n-1] + 1 
gen low = 0
gen high = year  - 2
rangestat (mean) m2gov6099 = mfy1gov6099, interval(year low high)
replace low = year - 1
replace high = low
rangestat (mean) m1gov6099 = mfy1gov6099, interval(year low high)
gen wgov6099 = (m1gov6099 + m2gov6099) / 2
replace wgov6099 = 0 in 1 			   
replace wgov6099 = m1gov6099 in 2
replace wgov6099 = wgov6099[_n-1] if mi(wgov6099) 
keep year wgov6099 
qui merge m:m year using "b&b90.dta", nogenerate
rename (yearcode year) (year yearold)
gen ideodistgov6099 = abs(wgov6099 - gov6099)	/* generate ideodistgov6099 */
bysort stnum (year): replace ideodistgov6099 = 0 if _n==1
egen gov6099_n1 = mean(gov6099) if year==1
gen malideodistgov6099=ideodistgov6099			/* generate malideodistgov6099 */
bysort stnum (year): replace malideodistgov6099 = abs(gov6099_n1-gov6099) if _n==1
drop gov6099_n1 wgov6099
saveold "b&b90temp.dta", replace
}
