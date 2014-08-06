d <- read.csv(filename, sep = ";", nrows = 80000)
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
