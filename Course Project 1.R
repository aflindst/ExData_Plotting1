## Reading and cleaning ----

require(sqldf)

filename <- "household_power_consumption.txt"
read_text <- 
'
select * from file 
where Date >= "2007-02-01"
and Date <= "2007-02-02"
'
test <- read.csv.sql(filename, sql = read_text, sep = ";")

#previewed with a text editor
#our data stops well before row 80,000
raw_d <- read.csv(filename, sep = ";", nrows = 80000)
months(as.Date(raw_d[1,1]))

d<-raw_d
#had to google this
#wrong!
#d$Date<-as.Date(d$Date)
d$Date2<-as.Date(d$Date, "%d/%m/%Y")
d<-d[(d$Date2 >= "2007-02-01") & (d$Date2 <= "2007-02-02"),]
d$DateTime<-paste(d$Date, d$Time)
d$DateTime<-strptime(d$DateTime, "%d/%m/%Y %H:%M:%S")

head(d)
head(raw_d)

for (i in 3:9)
  {
    d[,i] <- as.numeric(levels(d[,i]))[d[,i]]
  }

#str(d)
#2880/24/60

## Code for plot 1 ----

#color helper
#colors()

#create plot, change color
hist(d$Global_active_power, col="red3", 
     #change x-axis label
     xlab="Global Active Power (kilowatts)", 
     #change title
     main = "Global Active Power" )

#wrong, overwrites default title
#title(main = "Global Active Power")

## Code for plot 2 ----

#not quite right
par(col="black")
plot(x = d$DateTime, y = d$Global_active_power)#, col="black")
lines(x = d$DateTime, y = d$Global_active_power)

#read the help for plot, gets better
par(col="black")
plot(x = d$DateTime, type = "l", y = d$Global_active_power,
     ylab = "Global Active Power (kilowatts)",
     #setting label to NULL does not work, see ggplot2
     xlab = "")#, col="black")
#add title interactively (I dare you to subtract points for adding an informative title!)
title(main = "Global Power Over Time")

## Code for plot 3 ----
#picked this range trick up from a google
yrange<-range(c(d$Sub_metering_1,d$Sub_metering_2,d$Sub_metering_3))
plot(x=d$DateTime, y=d$Sub_metering_1, type="l", ylim=yrange, col="black",
     ylab = "Energy sub metering",
     xlab = "")
lines(x=d$DateTime, y=d$Sub_metering_2, type="l", ylim=yrange, col="red")
lines(x=d$DateTime, y=d$Sub_metering_3, type="l", ylim=yrange, col="blue")
legend(x = "topright", 
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty=c(1,1,1), # gives the legend appropriate symbols (lines)
    lwd=c(1,1,1),col=c("black", "red", "blue")) # gives the legend lines the correct color and width

## Plot 3 png ----
# sending a plot straight to png
png(filename = 'plot3.png', width = 480, height = 480, units = 'px')
  yrange<-range(c(d$Sub_metering_1,d$Sub_metering_2,d$Sub_metering_3))
  plot(x=d$DateTime, y=d$Sub_metering_1, type="l", ylim=yrange, col="black",
       ylab = "Energy sub metering",
       xlab = "")
  lines(x=d$DateTime, y=d$Sub_metering_2, type="l", ylim=yrange, col="red")
  lines(x=d$DateTime, y=d$Sub_metering_3, type="l", ylim=yrange, col="blue")
  legend(x = "topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         lty=c(1,1,1), # gives the legend appropriate symbols (lines)
         lwd=c(1,1,1),col=c("black", "red", "blue")) #legend lines color and width
dev.off()
# Yay! This seems to work fine