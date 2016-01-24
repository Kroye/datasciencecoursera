# Karoly Sumegi's homework 1/4

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
png('plot4.png',width=480, height=480)

# create a 2x2 grid for the plots
par(mfrow=c(2,2))
#par(mar = c(0,0,1,1) + 0.1,oma = c(5,4,0,0) + 0.1)
# create plot with the main plotting system
# plot 1,1
plot(d$DateTime,d$Global_active_power,type='l',main="",xlab="",ylab="Global Active Power",cex.lab=0.8,cex.axis=0.8)
# plot 1,2
plot(d$DateTime,d$Voltage,type='l',main="",xlab="datetime",ylab="Voltage",cex.lab=0.8,cex.axis=0.8)
# plot 2,1
plot(d$DateTime,d$Sub_metering_1,type='l',main="",xlab="",ylab="Energy sub metering",cex.lab=0.8,cex.axis=0.8,col='black')
lines(d$DateTime,d$Sub_metering_2,type='l',main="",xlab="",ylab="Energy sub metering",cex.lab=0.8,cex.axis=0.8,col='red')
lines(d$DateTime,d$Sub_metering_3,type='l',main="",xlab="",ylab="Energy sub metering",cex.lab=0.8,cex.axis=0.8,col='blue')
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c('black','red','blue'),cex=0.8)
# plot 2.2
plot(d$DateTime,d$Global_reactive_power,type='l',main="",xlab="datetime",ylab="Global Reactive Power",cex.lab=0.8,cex.axis=0.8)

# stop plotting device, this will save the current state of the device
dev.off()

# Now the resolution is not the best
