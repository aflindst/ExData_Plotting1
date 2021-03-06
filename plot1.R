## plot1.R ----
# Adam Lindstrom
# Project: Coursera\Exploratory Data Analysis\Course Project 1
# 08/09/2014
# This code reads the "household_power_consumption" data set and makes a histogram of global active power

## Read the data ----
#requires raw data file in working directory
filename <- "household_power_consumption.txt"

#previewed text file with a text editor, millions of rows!
#found our data (2007-02-01 to 2007-02-02) stops well before row 80,000
d <- read.csv(filename, sep = ";", nrows = 80000, 
              #read in ? as missing
              #prevents reading numeric as factor by accident 
              na.strings = "?") 
#convert to date from text format like "30/11/2000", make a new column
d$Date2<-as.Date(d$Date, "%d/%m/%Y")
#subsetting the required window of days
d<-d[(d$Date2 >= "2007-02-01") & (d$Date2 <= "2007-02-02"),]
#combine date and time into a single column
d$DateTime<-paste(d$Date, d$Time)
#convert to date from text format like "30/11/2000 23:59:00", overwrite
d$DateTime<-strptime(d$DateTime, "%d/%m/%Y %H:%M:%S")

## Initialize plot ---- 
# turn on png recorder
png(filename = 'plot1.png', width = 480, height = 480, units = 'px')

## Plot 1 ----
#color helper
#colors()

#create plot, change color
hist(d$Global_active_power, col="red3", 
     #change x-axis label
     xlab="Global Active Power (kilowatts)", 
     #change title
     main = "Global Active Power" )

## Cleanup ----
# close the png recorder
dev.off()