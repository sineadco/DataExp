setwd("~/R")
z <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,na.strings="?", stringsAsFactors=FALSE, dec=".")
o <- z[z$Date %in% c("1/2/2007","2/2/2007"),]
##str(o)
o[,1] <- as.Date(o[,1],format='%d/%m/%Y')
##class(z$Date)
o[,2] <- as.POSIXct(o[,2],format='%H:%M:%S')
##class(z$Time)
o[,2] <- strftime(o[,2], format='%H:%M:%S')
##combineddatetime <- strptime(paste(o$Date, o$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
o[,3] <- as.numeric(o[,3])
o[,4] <- as.numeric(o[,4])
o[,5] <- as.numeric(o[,5])
o[,6] <- as.numeric(o[,6])
o[,7] <- as.numeric(o[,7])
o[,8] <- as.numeric(o[,8])
##head(o)
o$combineddatetime<- as.POSIXct(paste(o$Date, o$Time))
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))
plot(o$Global_active_power~o$combineddatetime,ylab="Global Active Power (kilowatts)",xlab = "",type="l")
plot(o$Voltage~o$combineddatetime,ylab="Voltage",xlab = "datetime",type="l")
with(o, {
  plot(Sub_metering_1~combineddatetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~combineddatetime,col='Red')
  lines(Sub_metering_3~combineddatetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(o$Global_reactive_power~o$combineddatetime,ylab="Global_reactive_Power",xlab = "datetime", type ="h")
dev.off()