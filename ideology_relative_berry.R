####################################################
#File Name:	    ideology_relative_berry.r				
#Date:   		    May 08, 2018								
#Purpose:		    this file generates variable ideology_relative_berry of   
#               Cruz Aceves and Mallinson (2018): "Standardizing the  		
#               Measurement of Relative Ideology in Policy Diffusion Research"
#Input Files:	  b&b90temp.dta				
#Output File:	  b&b90complete.csv 

#Instructions:  1. Execute full syntax to generate variables ideology_relative_berry 
#               and generate b&b90complete.csv, which contains all variables 
#               necessary for the analysis
#               2. Execute analysis.do in Stata (to generate Tables 1 & 2 of the
#               publication)
####################################################
rm(list=ls())         #clear workspace

library(foreign)      #Read temporary data generated in "generate ideodistgov6099 and malideodistgov6099.do"
raw.data <- read.dta("b&b90temp.dta")
data <- raw.data
head(data)
df <- as.data.frame(matrix(NA, nrow=1, ncol=ncol(data)+1))  #data management to generate
names(df) <- c(colnames(data), "ideology_relative_berry")   #variable ideology_relative_berry
vars <- c("stnum", "year","gov6099", "adopt")               #and analysis data set, neccesary
adopts <- data[which(data$adopt==1),]                       #to execute analysis.do
adopts <- adopts[vars]
for(j in 1:nrow(data)){
  use.obs <- data[j,]
  if(use.obs$year<2){
    ideo.first <- data[which(data$year==min(data$year)),]
    ideo <- mean(ideo.first$gov6099)
    use.obs$ideology_relative_berry <- abs(use.obs$gov6099 - ideo)
    df <- rbind(df, use.obs)}
  else{
    ideo.adopts <- adopts[which(adopts$year<use.obs$year),]
    use.obs$ideology_relative_berry <- (sum(abs(use.obs$gov6099 - ideo.adopts$gov6099))/nrow(ideo.adopts))
    df <- rbind(df, use.obs)}
}
head(df)
df <- df[-1,]                                               #Delete row of null values
head(df)
data <- df
write.csv(df, file="b&b90complete.csv", row.names=FALSE)