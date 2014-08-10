## plot4.R ----
# Adam Lindstrom
# Project: Coursera\Exploratory Data Analysis\Course Project 1
# 08/09/2014
# This code reads the "household_power_consumption" data set and makes a 2x2 array of plots

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
png(filename = 'plot4.png', width = 480, height = 480, units = 'px')

# 2x2 plot array 
par(mfrow = c(2, 2))

## Plot (1, 1) ----
  # line chart of global active power vs. time
  par(col="black")
  plot(x = d$DateTime, y = d$Global_active_power,
       # draw lines instead of points
       type = "l", 
       ylab = "Global Active Power (kilowatts)",
       xlab = "")

## Plot (1, 2) ----
  # line chart of voltage vs. time
  par(col="black")
  plot(x = d$DateTime, y = d$Voltage, type = "l", 
       ylab = "Voltage",
       xlab = "datetime")

## Plot (2, 1) ----
  # overlay of three line charts, each sub-metering vs. time
  yrange<-range(c(d$Sub_metering_1,d$Sub_metering_2,d$Sub_metering_3))
  plot(x=d$DateTime, y=d$Sub_metering_1, type="l", ylim=yrange, col="black",
       ylab = "Energy sub metering",
       xlab = "")
  lines(x=d$DateTime, y=d$Sub_metering_2, type="l", ylim=yrange, col="red")
  lines(x=d$DateTime, y=d$Sub_metering_3, type="l", ylim=yrange, col="blue")
  # making legends is annoying, surely there is a better way
  legend(x = "topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         lty=c(1,1,1), # codes for line type
         lwd=c(1,1,1), # codes for line width
         col=c("black", "red", "blue")) # line color

## Plot (2, 2) ----
  # line chart of global reactive power vs. time 
  par(col="black")
  plot(x = d$DateTime, type = "l", y = d$Global_reactive_power,
       ylab = "Global_reactive_power",
       xlab = "datetime")

## Cleanup ----
# close the png recorder
dev.off()