## Read the data set
## Set the working directory
gwd.old <- getwd()
mywd <- "\\\\READYSHARE/USB_Storage/PC-Backup_24Mar2013/Ranga/r/CourseEra/Graphics/Project1"
setwd(mywd)
## read the downloaded datafile. hpc stands for household_power_consumption
hpc <- read.table("household_power_consumption.txt", header=TRUE,sep=";")
## Make the date into date format
hpc$Date <- as.Date(hpc$Date,format='%d/%m/%Y')
## Account for missing values
hpc$Date[as.character(hpc$Date)=="?"] <- NA
## subset data of interest
hp <- hpc[(hpc$Date == "2007-02-01" | hpc$Date == "2007-02-02"),]
a <- hp$Date
b <- hp$Time
cc <- paste(a,b,sep=" ")
dd <- strptime(cc, format="%Y-%m-%d %H:%M:%S", tz = "")
## Focus on the variable of interest, Account for data type and missing values
gap <- as.numeric(hp$Global_active_power)
gap <- gap[!is.na(gap)]
hp$Sub_metering_1[as.character(hp$Sub_metering_1)=="?"] <- NA
hp$Sub_metering_1 <- as.numeric(hp$Sub_metering_1)
hp$Sub_metering_1 <- hp$Sub_metering_1[!is.na(hp$Sub_metering_1)]
hp$Sub_metering_2[as.character(hp$Sub_metering_2)=="?"] <- NA
hp$Sub_metering_2 <- as.numeric(hp$Sub_metering_2)
hp$Sub_metering_2 <- hp$Sub_metering_2[!is.na(hp$Sub_metering_2)]
hp$Sub_metering_3[as.character(hp$Sub_metering_3)=="?"] <- NA
hp$Sub_metering_3 <- as.numeric(hp$Sub_metering_3)
hp$Sub_metering_3 <- hp$Sub_metering_3[!is.na(hp$Sub_metering_3)]
hp$Voltage[as.character(hp$Voltage)=="?"] <- NA
hp$Voltage <- as.numeric(hp$Voltage)
hp$Voltage <- hp$Voltage[!is.na(hp$Voltage)]
hp$Global_reactive_power[as.character(hp$Global_reactive_power)=="?"] <- NA
grp <- as.numeric(hp$Global_reactive_power)
grp <- grp[!is.na(grp)]

## Draw the plot. Stream the output to file. Provide title and x-axis labels

png(file="plot4.png",width=480, height=480)
par(mfrow=c(2,2))
plot(dd,gap,type="l",xlab="", ylab="Global Active Power (kilowatts)",yaxt='n')
axis(side=2, at=seq(0,6000,1000), labels=seq(0,6,1))
plot(dd,hp$Voltage, type="l",xlab="datetime",ylab="Voltage")
plot(dd, hp$Sub_metering_1,type="l", xlab="", ylab="Energy sub metering", yaxt='n')
axis(side=2, at=seq(0,60,10), labels=seq(0,60,10))
lines(dd, hp$Sub_metering_2,type="l", col="red")
lines(dd, hp$Sub_metering_3,type="l", col="blue")
legend("topright", c("Sub metering1","Sub metering2", "Sub metering3"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","blue","red"))
plot(dd,grp, type="l",xlab="datetime",ylab="Global Reactive Power")
dev.off()