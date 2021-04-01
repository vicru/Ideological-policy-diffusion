These files include data and estimation code for:

Cruz Aceves and Mallinson: "Standardizing the Measurement of Relative Ideology in Policy Diffusion Research" 		

INCLUDED:

  2 Text files:

README.txt				Describes the files and instructions to replicate resuts.
codebook				Describes the data.

  2 Stata data sets:

b&b90.dta 				lottery state-year data set shared by GNCP. 
b&b90temp.dta 				temporary lottery state-year data set generated in 
					"generate ideodistgov6099 and malideodistgov6099.do"
  1 Excel data set:

b&b90complete.csv			lottery state-year data set shared by GNCP plus our three
					alternative ideological distance variables, generated 
					in "ideology_relative_berry.r"

  2 Stata do files:

generate ideodistgov6099 and malideodistgov6099.do 		
					generates variables ideodistgov6099 and malideodistgov6099, 
					and data set b&b90temp.dta
analysis.do				Runs the tabulations and models in the paper.

  1 R file:

ideology_relative_berry.r		generates variable ideology_relative_berry and 
					data set b&b90complete.csv	
  1 MS Word file:

b&b.doc					Contains estimations presented in Table 2 (generated in "analysis.do").
					The generated table reports results with two-tailed hypotheses 
					tests, whereas in the article we reported one-tailed tests, 
					consistent with Berry and Berry (1990) and GNCP (2004). For this
					reason, stars of some intra-state variables of the generated 
					table and our article do not match. To see results of one-tailed 
					hypothesis tests, follow the instructions indicated on top of analysis.do. 

Instructions: 				1. Execute "generate ideodistgov6099 and malideodistgov6099.do" in Stata
					to generate variables ideodistgov6099 & malideodistgov6099, and data set b&b90temp.dta
					2. Execute ideology_relative_berry.r in R, to generate variable
					ideology_relative_berry and and data set b&b90complete.csv
					3. Execute analysis.do in Stata, to generate Tables 1 & 2 of the
					publication