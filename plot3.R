## Read and transform ----

d <- read.csv(filename, sep = ";", nrows = 80000)

#transform dates and times, filter data to selected days
d$Date2<-as.Date(d$Date, "%d/%m/%Y")
d<-d[(d$Date2 >= "2007-02-01") & (d$Date2 <= "2007-02-02"),]
d$DateTime<-paste(d$Date, d$Time)
d$DateTime<-strptime(d$DateTime, "%d/%m/%Y %H:%M:%S")

#fix the numeric factors caused by '?', NA's will populate automatically
for (i in 3:9)
{
  d[,i] <- as.numeric(levels(d[,i]))[d[,i]]
}

## Plot 3

