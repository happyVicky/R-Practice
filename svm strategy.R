#Trading an RSI using SVM
#The relative strength index, or RSI, compares the average size of the “up” moves to the average size of the “down” moves and normalizes it between 0 and 100. The conventional logic goes that once the asset has had more, significant upticks, it has become overbought, or overvalued, and is likely to decrease in price. Overbought is usually determined by an RSI value over 70, with opposite conditions representing oversold, or undervalued, at an RSI value of 30.
#However, these conditions don’t happen in a vacuum. There are also broader market trends at work. An RSI value over 70 in the middle of a strong uptrend might represent a continuation of the trend while a value of 70 during a downtrend could signify a great entry point. The problem is finding out exactly what conditions we should be looking for considering both factors.
#We could gather thousands of data points and try to find those relationships ourselves or we could use a Support Vector Machine, an algorithm designed to find non-linear patterns, to do the legwork for us.
#Let’s see what patterns we are able to find in a 3-period RSI and define a trend by comparing the open price to a 50-period simple moving average (SMA) using the AUD/USD 4 hour charts.

install.packages(c("quantmod","e1071","ggplot2"))
library(quantmod)
library(e1071)
library(ggplot2)

Data <- read.csv("AUDUSD.csv",header=TRUE)
#Our 4-hour bars of the Australian Dollar/US Dollar currency pair dating back to 01/01/2010.

RSI3 <- RSI(Op(Data),n = 3)
#The 3-period relative strength index calculated off the open

SMA50 <- SMA(Op(Data),n = 50)
Trend <- Op(Data)-SMA50

Price <- Cl(Data)-Op(Data)
Class <- ifelse(Price>0,"Up","Down")

DataSet <- data.frame(RSI3,Trend,Class)

SVM<-svm(Class~RSI3+Trend,data=Training, kernel="radial",cost=1,gamma=1/2)
#Build our support vector machine using a radial basis function as our kernel, the cost, or C, at 1, and the gamma function at ½, or 1 over the number of inputs we are using

TrainingPredictions<-predict(SVM,Training,type="class")
#Run the algorithm once more over the training set to visualize the patterns it found

TrainingData<-data.frame(Training,TrainingPredictions)
#Create a data set with the predictions

ggplot(TrainingData,aes(x=Trend,y=RSI3))+stat_density2d(geom="contour",aes(color=TrainingPredictions))+labs(title="SVM RSI3 and Trend Predictions",x="Open - SMA50",y="RSI3",color="Training Predictions")
#Now let’s see what patterns it was able to find

ShortRange1<-which(Test$RSI3 < 25 & Test$Trend > -.010 & Test$Trend < -.005)
ShortRange2<-which(Test$RSI3 > 70 & Test$Trend < -.005)
ShortRange3<-which(Test$RSI3 > 75 & Test$Trend > .015)
LongRange1<-which(Test$RSI3 < 25 & Test$Trend < -.02)
LongRange2<-which(Test$RSI3 > 50 & Test$RSI3 < 75 & Test$Trend > .005 & Test$Trend < .01)
#we have found a basic set of rules that the SVM uncovered, let’s test to see how well they hold up over new data, our test set.

ShortTrades<-Test[c(ShortRange1,ShortRange2,ShortRange3),]
ShortCorrect<-((length(which(ShortTrades[,3]=="Down")))/nrow(ShortTrades))*100
#Our short trades

LongTrades<-Test[c(LongRange1,LongRange2), ]
LongCorrect<-((length(which(LongTrades[,3]=="Up")))/nrow(LongTrades))*100
#Our long trades







