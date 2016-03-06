#################################################################
# This file downloads data regarding electrical
# power consumption in a household and makes a set of 4 exploratory
# plots from the consumption data for the 
# period 01/02/2007 -  02/02/2007
#################################################################

# Download file and load relevant data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
unzip(temp)
header <- read.table("household_power_consumption.txt", nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
consumptionData <- read.table("household_power_consumption.txt", sep =";", header = TRUE, 
                              stringsAsFactors = FALSE, 
                              na.strings = "?",
                              skip = grep("1/2/2007", readLines("household_power_consumption.txt")),
                              nrows = 2880)
colnames(consumptionData) <- unlist(header)
unlink(temp)

# convert dates and times to POSIXct 
dates <- with(consumptionData, as.POSIXct(strptime(paste0(as.character(Date), " ", as.character(Time)), "%d/%m/%Y %H:%M:%S")))

# Make and save plot to file
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

plot(consumptionData$Global_active_power ~ dates, type="l", xlab="", ylab="Global Active Power")

plot(consumptionData$Voltage ~ dates, type = "l", xlab = "datetime", ylab= "Voltage")

plot(consumptionData$Sub_metering_1 ~ dates, type="l", xlab="", ylab="Energy sub metering")
lines(consumptionData$Sub_metering_2 ~ dates, col = "red")
lines(consumptionData$Sub_metering_3 ~ dates, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(consumptionData$Global_reactive_power ~ dates, type = "l", xlab = "datetime", ylab= "Global_reactive_power")

dev.off()