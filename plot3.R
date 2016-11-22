# plot2.png

# Clear all existing objects
rm(list = ls())

# Read the text file into a data frame
df <- read.table("household_power_consumption.txt", stringsAsFactors = TRUE, header = TRUE, sep = ";")

# Replace "?" with NA
df[ df == "?" ] = NA

# Subset to the two dates we care about. No need for data conversion here.
ourDates <- subset(df, (Date == "1/2/2007"| Date == "2/2/2007"))

# We do need a data conversion for the Sub_metering attributes.

ourDates$Sub_metering_1 <- as.numeric(as.character(ourDates$Sub_metering_1))
ourDates$Sub_metering_2 <- as.numeric(as.character(ourDates$Sub_metering_2))
ourDates$Sub_metering_3 <- as.numeric(as.character(ourDates$Sub_metering_3))

# Make a datetime attribute
x <- with(ourDates, as.POSIXct(paste(as.Date(Date, format="%d/%m/%y"), Time)))

# make a plot
plot(x = x, y = ourDates$Sub_metering_1,  type = "l", col = "black", ylab = "Energy Sub Metering")
lines(x = x, y = ourDates$Sub_metering_2,  type = "l", col = "red")
lines(x = x, y = ourDates$Sub_metering_3,  type = "l", col = "blue")

# add the legend
legend("topright",pch=c(20), col = c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

# Save it as a PNG
dev.copy(png, "plot3.png")
dev.off()
