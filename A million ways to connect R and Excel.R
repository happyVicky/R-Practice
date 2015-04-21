#Reference: http://www.thertrader.com
#A million ways to connect R and Excel

#1 Read Excel Spreadsheet in R
#1) gdata: it requires you to install additional Perl libraries on window platforms but it's very powerful
require(gdata)
myDf <- read.xls("myfile.xlsx",sheet = 1, header = TRUE)
#2) RODBC: This is reported for completeness only. It’s rather dated; there are better ways to interact with Excel nowadays.
#3) XLConnect: It might be slow for large dataset but very powerful otherwise.
require(XLConnect)
wb <- loadWorkbook("myfile.xlsx")
myDf <- readWorksheet(wb,sheet = 1,head=TRUE)
#4) xlsx:  Prefer the read.xlsx2() over read.xlsx(), it’s significantly faster for large dataset.
require(xlsx)
read.xlsx2("myfile.xlsx", sheetName = "Sheet1")
#5)read.table(“clipboard”):  It allows to copy data from Excel and read it directly in R. Don't need to install package. This is the quick and dirty R/Excel interaction but it’s very useful in some cases.
myDf <- read.table("clipboard")

#2 Read R output in Excel
#There is one function that you need to know it’s write.table. You might also want to consider: write.csv which uses “.” for the decimal point and a comma for the separator and write.csv2 which uses a comma for the decimal point and a semicolon for the separator.
x <- cbind(rnorm(20),runif(20))
colnames(x) <- c("A","B")
write.csv(x,"/Users/wenzhuqiu/Desktop/myfile.csv",row.names=FALSE)

#3 Execute R code in VBA

#4 Execute R code from an Excel spreadsheet

#5 Execute VBA code in R 
#http://stackoverflow.com/questions/19404270/run-vba-script-from-r

#6 Fully integrate R and Excel


