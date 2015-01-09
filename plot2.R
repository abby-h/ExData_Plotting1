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

## creates plot in PNG file
png("plot2.png", width=480, height=480, bg='transparent')
with(subset_data, plot(DateTime,Global_active_power,type="l",xaxt="n",xlab=" ",ylab="Global Active Power (kilowatts)"))
axis.POSIXct(1,at=seq(min(subset_data$DateTime),max(seq.POSIXt(max(subset_data$DateTime),by="day",length.out=2)),"days"),format="%a")
dev.off()
