## Exploratory Data Analysis - DataScience Specialization Coursera
## Course Project 1 - Part 4
## Elena Cruz Martin, 2015-06-05
## This script loads the data coming from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip, taking only
## those days that are relevant for the excercise (2007-02-01 to 2007-02-02) and plotting an histogram of the Global Active Power data according
## to the exercise specification. The plot will be saved as a 480x480 png file called plot4.png

library(datasets)
library(dplyr)

path2Data <- "../exdata-data-household_power_consumption.zip" ## This path should be modified according to the local route in the machine
fileName <- "household_power_consumption.txt"

##Optional code to download data source
##path2Source <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
##download.file(path2Source,destfile=path2Data,method="curl")
##dateDownloaded <- date()

plotData <- read.table(unz(path2Data,fileName), header=TRUE, sep=";",na.strings="?")

## Set the start and end dates
startDate="01/02/2007"
endDate="02/02/2007"
dateFormat="%d/%m/%Y" ##Format to convert dates

## Convert date to date format
plotData$Date <- as.Date(plotData$Date,dateFormat)

## Filter the data to select only the required rows using dplyr
filteredData <- filter(plotData,Date >= as.Date(startDate,dateFormat),Date <= as.Date(endDate,dateFormat))

## Paste date and time to allow the x axis to be continuous
dateTime   <- as.POSIXct(paste(filteredData$Date,filteredData$Time, sep=" ")) 

## Set locale to English to get the proper X axis titles (since my laptop is in Spanish)
Sys.setlocale('LC_TIME', 'en_GB.UTF-8')

#Send a copy the drawing to png (to avoid cutting the legend)
pngFile <- "plot4.png"
png(pngFile, width=480,height=480)

#Plot the drawings
par(mfrow = c(2, 2))
# Drawing 1
#Plot the drawing
plot(dateTime,filteredData$Global_active_power, main="", xlab="", ylab="",type="l")
title(ylab="Global Active Power")

# Drawing 2
#Plot the drawing
plot(dateTime,filteredData$Voltage, main="", xlab="", ylab="",type="l")
title(ylab="Voltage",xlab="datetime")

#Drawing 3
plot(dateTime,filteredData$Sub_metering_1, main="", xlab="", ylab="",type="l",col="black")
lines(dateTime,filteredData$Sub_metering_2, main="", xlab="", ylab="",type="l",col="red")
lines(dateTime,filteredData$Sub_metering_3, main="", xlab="", ylab="",type="l", col="blue")
title(ylab="Energy sub metering")
legend("topright",col= c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,bty="n")

# Drawing 4
#Plot the drawing
plot(dateTime,filteredData$Global_reactive_power, main="", xlab="", ylab="",type="l")
title(ylab="Global_reactive_power",xlab="datetime")


## Close the drawing device
dev.off()

##Set locale back to Spanish
Sys.setlocale('LC_TIME', 'es_ES.UTF-8')


##Optional code to clean removed data
##file.remove(path2Data)