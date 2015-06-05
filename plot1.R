## Exploratory Data Analysis - DataScience Specialization Coursera
## Course Project 1 - Part 1
## Elena Cruz Martin, 2015-06-05
## This script loads the data coming from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip, taking only
## those days that are relevant for the excercise (2007-02-01 to 2007-02-02) and plotting an histogram of the Global Active Power data according
## to the exercise specification. The plot will be saved as a 480x480 png file called plot1.png

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

#Send a copy the drawing to png (with right dimensions)
pngFile <- "plot1.png"
png(pngFile, width=480,height=480)

#Plot the drawing
hist(filteredData$Global_active_power, main="", xlab="", col="red")
title(main="Global Active Power",xlab="Global Active Power (kilowatts)")

## Close the drawing device
dev.off()


##Optional code to clean removed data
##file.remove(path2Data)