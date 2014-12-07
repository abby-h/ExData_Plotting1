## set working directory to the location of the file 

## loads data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", as.is = TRUE)

## creates date and time column
dateTime <- paste(data$Date, data$Time, sep=' ')
dateTime <- strptime(dateTime, format="%d/%m/%Y %H:%M:%S")

## adds datetime column to data frame
data$DateTime <- dateTime

## subsets to just the dates we want
subset_data <-data[data$Date %in% c("1/2/2007", "2/2/2007"),]

##creates plot in PNG file
png("plot1.png", width=480, height=480, bg='transparent')
hist(subset_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

