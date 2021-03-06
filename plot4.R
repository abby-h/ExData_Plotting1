## set working directory to the location of the file 
setwd("Location of household_power_consumption.txt file")

## loads data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", as.is = TRUE)

## creates date and time column
dateTime <- paste(data$Date, data$Time, sep=' ')
dateTime <- strptime(dateTime, format="%d/%m/%Y %H:%M:%S")

## adds datetime column to data frame
data$DateTime <- dateTime

## subsets to just the dates we want
subset_data <-data[data$Date %in% c("1/2/2007", "2/2/2007"),]

png("plot4.png", width=480, height=480, bg='transparent')
par(mfrow = c(2,2)) ##sets graphics pane to have 2 rows, 2 columns
with(subset_data, { ##sets dataset
##1. Top Left chart
plot(DateTime,Global_active_power,type="l",xaxt="n",xlab=" ",ylab="Global Active Power")
axis.POSIXct(1,at=seq(min(subset_data$DateTime),max(seq.POSIXt(max(subset_data$DateTime),by="day",length.out=2)),"days"),format="%a")

##2. Top Right chart
plot(DateTime,Voltage,type="l",xaxt="n",xlab="datetime",ylab="Voltage")
axis.POSIXct(1,at=seq(min(subset_data$DateTime),max(seq.POSIXt(max(subset_data$DateTime),by="day",length.out=2)),"days"),format="%a")

##3. Bottom Left chart
plot(DateTime,Sub_metering_1,type="l",xaxt="n",xlab=" ",ylab="Energy sub metering")
lines(DateTime,Sub_metering_2,col="red",xaxt="n")
lines(DateTime,Sub_metering_3,col="blue",xaxt="n")
axis.POSIXct(1,at=seq(min(subset_data$DateTime),max(seq.POSIXt(max(subset_data$DateTime),by="day",length.out=2)),"days"),format="%a")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("blacK","red","blue"),bty="n")

##4. Bottom Right chart
plot(DateTime,Global_reactive_power,type="l",xaxt="n",xlab="datetime")
axis.POSIXct(1,at=seq(min(subset_data$DateTime),max(seq.POSIXt(max(subset_data$DateTime),by="day",length.out=2)),"days"),format="%a")
})
dev.off()