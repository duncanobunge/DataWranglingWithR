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