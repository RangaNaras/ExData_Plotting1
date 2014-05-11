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
## Focus on the variable of interest, Account for data type and missing values
gap <- as.numeric(hp$Global_active_power)
gap <- gap[!is.na(gap)]
## Draw the histogram. Stream the output to file. Provide title and x-axis labels
hist(gap, breaks=12, col="red")
png(file="plot1.png",width=480, height=480)
hist(gap,breaks=12, col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)", xaxt='n',yaxt='n')
axis(side=1, at=seq(0,6000,2000), labels=seq(0,6,2))
axis(side=2, at=seq(0,1600,200), labels=seq(0,1600,200))
dev.off()