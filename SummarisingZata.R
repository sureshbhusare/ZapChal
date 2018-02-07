##############################################
# Name : Suresh Bhusare
##############################################

# Reading Zappos data from the file 
# loading packages
rm(list=ls(all=TRUE))
library(data.table)
library(tidyverse)
library(gdata)
library(openxlsx)
library(ggplot2)

xlRead <- read.xlsx('data_science_analytics_2018_data.xlsx',sheet = 1)
xlRead$isCancelled <- 0

for (i in 1 : length(xlRead$InvoiceNo))
{
  if (grepl('C', xlRead$InvoiceNo[i] ))
  {
    xlRead$isCancelled[i] <- 1
  } 
}
typeof(finalDF)
finalDF <- as.data.frame(xlRead, col.names = names(xlRead))
summary(finalDF)

plotbasic <- ggplot(data = finalDF,  aes(y = InvoiceDate, x = CustomerID)) + geom_point()
plotbasic


# Cleaning the data for the customer id that were empty 
finalDF <- na.omit(finalDF)

# 1st Insight
table(finalDF$isCancelled) # 1st Insight 
# Splitting the data for the cnacelled and orderd items 
ordereditmes <- subset(finalDF, finalDF$isCancelled == 0)
cancelleditems <- subset(finalDF, finalDF$isCancelled == 1)

write.csv(finalDF,'CleanData.csv')
write.csv(ordereditmes,'Order.csv')
write.csv(cancelleditems,'Cancel.csv')
