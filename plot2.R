## Exploratory Data Analysis - DataScience Specialization Coursera
## Course Project 1 - Part 2
## Elena Cruz Martin, 2015-06-05
## This script loads the data coming from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip, taking only
## those days that are relevant for the excercise (2007-02-01 to 2007-02-02) and plotting an histogram of the Global Active Power data according
## to the exercise specification. The plot will be saved as a 480x480 png file called plot2.png

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

#Plot the drawing
plot(dateTime,filteredData$Global_active_power, main="", xlab="", ylab="",type="l")
title(ylab="Global Active Power (kilowatts)")

#Copy the drawing to png
pngFile <- "plot2.png"
dev.copy(png, file=pngFile)
dev.off()

##Set locale back to Spanish
Sys.setlocale('LC_TIME', 'es_ES.UTF-8')


##Optional code to clean removed data
##file.remove(path2Data)