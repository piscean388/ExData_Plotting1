#################################################################
# This file downloads data regarding electrical
# power consumption in a household and makes a time series plot 
# of Global Active Power for the period 01/02/2007 -  02/02/2007
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
png(filename = "plot2.png", width = 480, height = 480)
plot(consumptionData$Global_active_power ~ dates, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
