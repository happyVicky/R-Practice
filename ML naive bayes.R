install.packages("quantmod")
library("quantmod")
#Allows us to import the data we need
install.packages("lubridate")
library("lubridate")
#Makes it easier to work with the dates
install.packages("e1071")
library("e1071")
#Gives us access to the Naïve Bayes classifier
startDate = as.Date("2012-01-01")
# The beginning of the date range we want to look at
endDate = as.Date("2014-01-01") 
# The end of the date range we want to look at
getSymbols("AAPL", src = "yahoo", from = startDate, to = endDate) 
# Retrieving Apple’s daily OHLCV from Yahoo Finance
DayofWeek<-wday(AAPL, label=TRUE)
#Find the day of the week
PriceChange<- Cl(AAPL) - Op(AAPL) 
#Find the difference between the close price and open price
Class<-ifelse(PriceChange>0,"UP","DOWN") 
#Convert to a binary classification. (In our data set, there are no bars with an exactly 0 price change so, for simplicity sake, we will not address bars that had the same open and close price.)
DataSet<-data.frame(DayofWeek,Class)
#Create our data set
MyModel<-naiveBayes(DataSet[,1],DataSet[,2])
#The input, or independent variable (DataSet,1]), and what we are trying to predict, the dependent variable (DataSet[,2]).

#Improve the model
EMA5<-EMA(Op(AAPL),n = 5)
#We are calculating a 5-period EMA off the open price
EMA10<-EMA(Op(AAPL),n = 10)
#Then the 10-period EMA, also off the open price
EMACross <- EMA5 - EMA10 
#Positive values correspond to the 5-period EMA being above the 10-period EMA
EMACross<-round(EMACross,2)
DataSet2<-data.frame(DayofWeek,EMACross, Class)
DataSet2<-DataSet2[-c(1:10),]
#We need to remove the instances where the 10-period moving average is still being calculated
TrainingSet<-DataSet2[1:328,]
#We will use ⅔ of the data to train the model
TestSet<-DataSet2[329:492,] 
#And ⅓ to test it on unseen data
EMACrossModel<-naiveBayes(TrainingSet[,1:2],TrainingSet[,3])
table(predict(EMACrossModel,TestSet),TestSet[,3],dnn=list('predicted','actual'))









