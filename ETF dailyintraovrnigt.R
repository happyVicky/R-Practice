#Overnight Return in ETF Prices
#Reference: http://www.thertrader.com

##Conclusion##

#For US Equity markets (SPY, QQQ, IWM), Emerging Equity Markets (EEM),
#Metals (GLD,GDX,SLV) and Investment Grades (LQD) the bulk of the return is definitely
#made overnight. Intraday returns tend to deteriorate the overall performance
#(intraday return < 0)
#
#The exact opposite is true for European Equity Markets (EFA,EWG,EWU,EWL),
#US Bonds (SHY,IEF,TLT) and Oil (USO). Overnight returns are detracting
#significantly from the overall performance.

library(quantmod)

symbolList <- c("SPY","QQQ","IWN","EEM","EFA","EWG","EWU","EWL","EWJ","FXI","EWS")

results <- NULL

for(ii in symbolList)
{
  data <- getSymbols(Symbols = ii,src = "yahoo",from = "2000-01-01",auto.assign=FALSE)
  colnames(data) <- c("open","high","low","close","volume","adj.")
  dailyRtn <- (as.numeric(data[2:nrow(data),"close"])/as.numeric(data[1:(nrow(data)-1),"close"])-1)
  intradayRtn <- (as.numeric(data[,"close"])/as.numeric(data[,"open"])-1)
  overnightRtn <- (as.numeric(data[2:nrow(data),"open"])/as.numeric(data[1:(nrow(data)-1),"close"])) - 1
  #accumulative return
  results <- rbind(results,cbind(paste(round(100*sum(dailyRtn,na.rm=TRUE,1)),"%",sep = ""),
                                 paste(round(100*sum(intradayRtn,na.rm=TRUE,1)),"%",sep = ""),
                                 paste(round(100*sum(overnightRtn,na.rm=TRUE,1)),"%",sep = "")))
}

colnames(results) <- c("dailyRtn","intradayRtn","overnightRtn")
rownames(results) <- symbolList

print(results)



#SPY
#The first, and most popular, ETF in the U.S. is the SPDR S&P 500 ETF (AMEX:SPY).
#It tracks one of the most popular indexes in the world, the S&P 500 Index. It is
#managed by State Street Global Advisors, one of the largest mangers of ETFs in the
#world. The objective of the SPY ETF is to duplicate as closely as possible, before
#expenses, the total return of the S&P 500 Index. The S&P 500 is a market capitalization
#index of 500 of the largest companies in the U.S. According to Standard and Poor's, it
#represents about 75% of the market capitalization of the total U.S. equity market. It is
#considered to be a large cap index. 

#QQQ
#PowerShares QQQ™, formerly known as "QQQ" or the "NASDAQ- 100 Index Tracking Stock®", is
#an exchange-traded fund based on the Nasdaq-100 Index®. The Fund will, under most
#circumstances, consist of all of stocks in the Index. The Index includes 100 of the largest
#domestic and international nonfinancial companies listed on the Nasdaq Stock Market based on
#market capitalization. The Fund and the Index are rebalanced quarterly and reconstituted
#annually.

#IWN
#iShares Russell 2000 Value ETF is an exchange-traded fund incorporated in the USA. The Fund
#seeks investment results that correspond to the performanceof the Russell 2000 Value Index.
#The Index measures the performance of the small-capitalization value sector of the U.S.
#equity market.

#EEM
#The MSCI Emerging Markets Index is a free float-adjusted market capitalization index that is
#designed to measure equity market performance in the global emerging markets.
#The MSCI Emerging Markets Index was launched in 1988. Since then, emerging markets have become
#an important and integrated part of a global equity portfolio allocation. In 1988, there were
#just 10 countries in the MSCI Emerging Markets Index, representing less than 1% of world market
#cap. Today the MSCI Emerging Markets Index covers over 800 securities across 23 markets and
#represents approximately 13% of world market cap. Numerous ETFs based on the MSCI Emerging Markets
#Index have been launched and are listed on major stock exchanges around the world.

#EFA
#iShares MSCI EAFE Index offers diversified exposure to large- and mid-cap stocks in developed Europe,
#Asia, and Australia. European stocks currently represent about two thirds of the portfolio, with
#Australia and Japan representing most of the balance. While this may be a suitable core holding for
#investors with a high concentration of domestic and Canadian stocks, iShares Core MSCI EAFE Index targets
#stocks in the same countries but offers a more comprehensive portfolio that includes small-cap stocks for
#a fraction of EFA’s cost.

#EWG
#iShares MSCI Germany ETF, formerly iShares MSCI Germany Index Fund (the Fund), is an exchange-traded fund.
#The Fund seeks to provide investment results that correspond generally to the price and yield performance,
#before fees and expenses, of publicly traded securities in the German market, as measured by the MSCI Germany
#Index (the Index). The Index seeks to measure the performance of the Germany equity market. It is a
#capitalization-weighted index that aims to capture 85% of the (publicly available) total market capitalization.
#The Fund invests in sectors, such as consumer discretionary, financials, materials, industrials, healthcare,
#information technology, utilities, telecommunication services and consumer staples. BlackRock Fund Advisors (BFA)
#serves as the investment adviser to the Fund.

#EWU
#IShares MSCI United Kingdom offers exposure to large- and mid-cap stocks within the United Kingdom. These
#include quality global companies like HSBC Holdings , Royal Dutch Shell , BP , GlaxoSmithKline , and British
#American Tobacco that generate a majority of their revenue outside of the United Kingdom. This limits the
#fund’s sensitivity to the local economy and makes it more sensitive to the global market cycle. Like most of
#its peers, this fund does not hedge its currency exposure.

#EWL
#IShares MSCI Switzerland Capped offers exposure to large- and mid-cap stocks in Switzerland. Although it covers
#85% of the country's investable market capitalization, the fund has fewer than 40 holdings and is heavily
#concentrated. In fact, the top-three holdings represent nearly half the portfolio. This introduces a high
#degree of company-specific risk. Switzerland is home to some of the world's largest multinational companies,
#such as Nestle SA and Novartis AG . Defensive sectors like consumer defensive and health care account for more
#than half of the fund's assets, which can help reduce volatility. The standard deviation of the fund's returns
#over the trailing 10 years through October 2014 (16.5%) was less than the MSCI Europe Index's (20.1%).

#EWJ
#IShares MSCI Japan provides broad exposure to Japanese equities and is suitable as a satellite holding 
#or as a tactical tool for those who want to increase their allocation to Japan. EWJ is tilted toward
#large export-oriented automakers and industrial companies, as well as Japanese financial firms.

#FXI
#IShares China Large-Cap tracks an index that includes the 50 largest Chinese companies listed in Hong Kong.
#While this is the most liquid exchange-traded fund that provides exposure to Chinese companies, we suggest
#that investors consider a fund with a broader mandate. 

#EWS
#IShares MSCI Singapore has a heavy exposure to financials and industrial firms, almost all of which have
#operations in Southeast Asia and China. Many of the holdings in this fund are well-run companies with healthy
#balance sheets. As such, this fund can be used as a vehicle to play the region's economic growth. This fund
#is suitable for use as a satellite holding.



