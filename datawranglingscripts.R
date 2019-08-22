#Author:Obunge
#Date:20/08/2019
#using titanic dataset
#Using tidyr and dplyr

#load the necessar packages
library(tidyr)
library(dplyr)

#load the dataset into the working space
library(readr)
ACRoAP_ToBeCleaned <- read_csv("data/ACRoAP.csv")
View(ACRoAP_ToBeCleaned)

#convert the data frame to a tible
ACRoAP_ToBeCleaned <- tbl_df(ACRoAP_ToBeCleaned)
View(ACRoAP_ToBeCleaned)

#summarise the dataset
summary(ACRoAP_ToBeCleaned)

#check the structure of the dataset variable
str(ACRoAP_ToBeCleaned)

#---This section deals with missing data---#

View(is.na(ACRoAP_ToBeCleaned)) # identify the missing values in the dataset
sum(is.na(ACRoAP_ToBeCleaned)) #get the sum of missing observations
sum(is.na(ACRoAP_ToBeCleaned$name))

# sumOfMissingValuesPerColumn<- function(x){
#     y <- names(x)
#     n <- length(y)
#     for(i in  1:n)
#       
#       {
#         colName <-y[i]
#         sumOfMissingVal <- sum(is.na(x$colName))
#         
#         cat(colName, sep="\t",sumOfMissingVal, "\n")
#       }
# }
# sumOfMissingValuesPerColumn(ACRoAP_ToBeCleaned)

#function returns the sum of missing values in the entire data frame
sumOfMissingValues <- function(x){sum(is.na(x))}
apply(ACRoAP_ToBeCleaned, 2,sumOfMissingValues) #returns sum of NA per colName
apply(ACRoAP_ToBeCleaned, 1,sumOfMissingValues) #returns sum of Na per rowIndex

#Safe Maximum threshold for missing data of sample should be atmost 5% of total sample dataset
#Calculate Percentage of NA per Columname and RowIndex - create a function percentgeOfMissingData
percentgeOfMissingData <- function(x){(sum(is.na(x))/length(x))*100}
View(apply(ACRoAP_ToBeCleaned, 2,percentgeOfMissingData)) #returns sum of NA per colName
View(apply(ACRoAP_ToBeCleaned, 1,percentgeOfMissingData)) #returns sum of Na per rowIndex

#find the pattern of missing observations in our dataset
library(mice)
View(md.pattern(ACRoAP_ToBeCleaned))

#visual representation of the missing dataset
install.packages('VIM')
library(VIM)
aggr_plot <- aggr(ACRoAP_ToBeCleaned, col=c('navyblue','red'), 
                  numbers=TRUE, sortVars=TRUE, labels=names(ACRoAP_ToBeCleaned), 
                  cex.axis=.7, gap=3, ylab=c("Histogram of missing data","Pattern"))
#imputing data to fill the missing values using Predictive mean marching (pmm)
imputedData <- mice(ACRoAP_ToBeCleaned,m=5,maxit=50,meth='pmm',seed=500)
summary(imputedData )

# m=5 refers to the number of imputed datasets. Five is the default value.
# meth='pmm' refers to the imputation method. 
# In this case we are using predictive mean matching as imputation method.
# Other imputation methods can be used, 
# type methods(mice) for a list of the available imputation methods.

#checking the imputed data for specific columns
imputedData$imp$reviews.id
#check the method used for imputation
imputedData$meth
