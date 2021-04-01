/*	****************************************************************
File Name:		analysis.do				
Date:   		May 08, 2018								
Purpose:		this file reproduces Tables 1 & 2 of  Cruz Aceves and Mallinson 
				(2018): "Standardizing the Measurement of Relative Ideology in 
				Policy Diffusion Research" 		
Input Files:	b&b90temp.dta				
Output File:	b&b.doc 
Version:		Stata 13
		
Instructions: 	1. install "outreg" package
				2. execute code until line 45 to generate and export Table 2 to b&b.doc 
				Table 1 is shown in Stata's results' window.
				
Notes:			The generated table reports results with two-tailed hypotheses 
				tests, whereas in the article we reported one-tailed tests, 
				consistent with Berry and Berry (1990) and GNCP (2004). For this
				reason, stars of some intra-state variables of the generated 
				table and our article do not match. To see results of one-tailed 
				hypothesis tests (results' window), execute code starting in line 48. 
	****************************************************************	*/
import delimited "b&b90complete.csv", clear 
destring religion, replace force

*"Table 1. Correlation Coefficients for the ideological distance variables"
corr ideodistgov6099 malideodistgov6099 wideodif ideology_relative_berry

/*
"Table 2. Determinants of state lottery adoptions (1964-1986) using 
GNCP relative ideology and alternative specifications"
*/
qui{ 
logit adopt eelct1 elect2 fiscal  income  religion  neighbor, robust
outreg, ctitles("","Model 1") bd(3) starlevels(5) 
logit adopt eelct1 elect2 fiscal  income  religion  neighbor  wideodif  year gov6099, robust
outreg, ctitles("","Model 2") bd(3) starlevels(5) merge
logit adopt eelct1 elect2 fiscal  income  religion  neighbor  ideodistgov6099 year gov6099, robust
outreg, ctitles("","Model 3") bd(3) starlevels(5) merge
logit adopt eelct1 elect2 fiscal  income  religion  neighbor malideodistgov6099   year gov6099, robust
outreg, ctitles("","Model 4") bd(3) starlevels(5) merge
logit adopt eelct1 elect2 fiscal  income  religion  neighbor ideology_relative_berry year gov6099, robust
}
outreg using ///
"b&b.doc", ///
ctitles("","Model 5") bd(3) starlevels(5) merge replace note(Two-tailed tests. Robust standard errors in parentheses.)

*One-tailed hypothesis tests
qui{ 
logit adopt eelct1 elect2 fiscal  income  religion  neighbor, robust
noisily: display "Model 1"
foreach j in elect2 fiscal  religion {
test `j'
local sign_`j'= sign(_b[`j'])
noisily: display "H_0: coef `j'< =0  p-value = " 1-normal(`sign_`j''*sqrt(r(chi2)))
noisily: display "H_0: coef `j'> =0  p-value = " normal(`sign_`j''*sqrt(r(chi2)))
}
logit adopt eelct1 elect2 fiscal  income  religion  neighbor  wideodif  year gov6099, robust
noisily: display "Model 2"
foreach j in elect2 religion  wideodif {
test `j'
local sign_`j'= sign(_b[`j'])
noisily: display "H_0: coef `j'< =0  p-value = " 1-normal(`sign_`j''*sqrt(r(chi2)))
noisily: display "H_0: coef `j'> =0  p-value = " normal(`sign_`j''*sqrt(r(chi2)))
}
logit adopt eelct1 elect2 fiscal  income  religion  neighbor  ideodistgov6099 year gov6099, robust
noisily: display "Model 3"
foreach j in elect2 ideodistgov6099 {
test `j'
local sign_`j'= sign(_b[`j'])
noisily: display "H_0: coef `j'< =0  p-value = " 1-normal(`sign_`j''*sqrt(r(chi2)))
noisily: display "H_0: coef `j'> =0  p-value = " normal(`sign_`j''*sqrt(r(chi2)))
}
logit adopt eelct1 elect2 fiscal  income  religion  neighbor malideodistgov6099 year gov6099, robust
noisily: display "Model 4"
foreach j in elect2 malideodistgov6099 {
test `j'
local sign_`j'= sign(_b[`j'])
noisily: display "H_0: coef `j'< =0  p-value = " 1-normal(`sign_`j''*sqrt(r(chi2)))
noisily: display "H_0: coef `j'> =0  p-value = " normal(`sign_`j''*sqrt(r(chi2)))
}
logit adopt eelct1 elect2 fiscal  income  religion  neighbor ideology_relative_berry year gov6099, robust
noisily: display "Model 5"
foreach j in elect2 ideology_relative_berry {
test `j'
local sign_`j'= sign(_b[`j'])
noisily: display "H_0: coef `j'< =0  p-value = " 1-normal(`sign_`j''*sqrt(r(chi2)))
noisily: display "H_0: coef `j'> =0  p-value = " normal(`sign_`j''*sqrt(r(chi2)))
}
}
