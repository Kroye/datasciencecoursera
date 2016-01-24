# Karoly Sumegi's homework 1/2

library(ggplot2)
# read data, I could have also used read.csv2 function and the separator would have been automatic
d<-read.table("household_power_consumption.txt",sep=";",header=TRUE)

# create datetime R coloumn
dt<-paste(d$Date,d$Time)
dt<-strptime(dt, "%d/%m/%Y %H:%M:%S")

# adding DateTime to our dataframe
d$DateTime<-dt
# selecting rows within the specified window
# it is not that much of a data so I have allowed myself the comfort to have the filtering this late 
d<-d[d$DateTime>="2007-02-01 00:00:00" & d$DateTime<"2007-02-03 00:00:00",]
# summary(d$DateTime) will prove that the filtering was correct

# lapply to convert all the columns non date columns
# using lambda function here to fix the factors to numeric values
d[,3:8]<-lapply(d[,3:8],function(x){as.numeric(levels(x))[x]})

# start plotting device
png('plot2.png',width=480, height=480, res=120)
# create plot with the main plotting system
plot(d$DateTime,d$Global_active_power,type='l',main="",xlab="",ylab="Global Active Power (kilowatts)",cex.lab=0.8,cex.axis=0.7)
# stop plotting device, this will save the current state of the device
dev.off()
