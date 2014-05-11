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
## Draw the histogram. Stream the output to file. Provide title and x-axis labels
plot(dd,gap,type="l")
png(file="plot2.png",width=480, height=480)
plot(dd,gap,type="l",xlab="", ylab="Global Active Power (kilowatts)",yaxt='n')
axis(side=2, at=seq(0,6000,1000), labels=seq(0,6,1))
dev.off()