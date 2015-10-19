# Week 3 Quiz Getting and Cleaning Data
## Question 1
### codebook
urlCodebook <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
fileCodebook <- "getdata-data-PUMSDataDict06.pdf"
download.file(url = urlCodebook, destfile = fileCodebook, method = "curl")
### data file
urlData <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
fileData <- "getdata-data-ss06hid.csv"
download.file(url = urlData, destfile = fileData, method = "curl")
###
housing <- read.csv(file = fileData)
View(housing)
str(housing)
which(housing$ACR == 3 & housing$AGS == 6)[1:3]
# [1] 125 238 262

## Question 2
###
install.packages("jpeg")
library(jpeg)
### data
urlPicture <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
filePicture <- "getdata-jeff.jpg"
download.file(url = urlPicture, destfile = filePicture, method = "curl")
###
jeff <- readJPEG(filePicture, native = TRUE)
quantile(jeff, probs = c(0.3,0.8))
#      30%       80% 
#-15258512 -10575416
#(some Linux systems may produce an answer 638 different for the 30th quantile)

## Question 3
###
urlData1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileData1 <- "getdata-data-GDP.csv"
download.file(url = urlData1, destfile = fileData1, method = "curl")
###
urlData2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
fileData2 <- "getdata-data-EDSTATS_Country.csv"
download.file(url = urlData2, destfile = fileData2, method = "curl")
###
gdp <- read.csv(fileData1, header = FALSE, skip = 5, nrows = 190)
edu <- read.csv(fileData2)
###
m <- merge(x = gdp[, c(1,2)], y = edu[, 1:3], by.x = "V1", by.y = "CountryCode" )
nrow(m)
# [1] 189
m[order(m$V2, decreasing = TRUE), ][13, ]
#     V1  V2           Long.Name        Income.Group
# 93 KNA 178 St. Kitts and Nevis Upper middle income

## Question 4
###
aggregate(V2 ~ Income.Group, data = m[m$Income.Group %in% c("High income: nonOECD", "High income: OECD"), ], FUN = mean)
#           Income.Group       V2
# 1 High income: nonOECD 91.91304
# 2    High income: OECD 32.96667

## Question 5
###
breaks <- quantile(m$V2, probs = c(0,0.2,0.4,0.6,0.8,1), type = 1 )
table(m$Income.Group, cut( x = m$V2, breaks = breaks))
