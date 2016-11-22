#plot4

# Clear all existing objects
rm(list = ls())

# Read the text file into a data frame
df <- read.table("household_power_consumption.txt", stringsAsFactors = TRUE, header = TRUE, sep = ";")

# Replace "?" with NA
df[ df == "?" ] = NA


# Subset to the two dates we care about. No need for data conversion here.
ourDates <- subset(df, (Date == "1/2/2007"| Date == "2/2/2007"))

ourDates$Global_active_power

# We need data conversions several attributes.
ourDates$Global_reactive_power <- as.numeric(as.character(ourDates$Global_reactive_power))
ourDates$Sub_metering_1 <- as.numeric(as.character(ourDates$Sub_metering_1))
ourDates$Sub_metering_2 <- as.numeric(as.character(ourDates$Sub_metering_2))
ourDates$Sub_metering_3 <- as.numeric(as.character(ourDates$Sub_metering_3))
ourDates$Voltage <- as.numeric(as.character(ourDates$Voltage))

#Get the datetimes for the the plots
x <- with(ourDates, as.POSIXct(paste(as.Date(Date, format="%d/%m/%y"), Time)))

#Subset to Global_active
y = ourDates$Global_active_power


#make a container to hold the 4 plots
par(mfrow = c(2,2))

# Make the plots

plot(x,y,type = "l", col = 'blue', ylab = "Global Active Power")
plot(x = x, y = ourDates$Voltage,  type = "l", col = "black", ylab = "Voltage")
plot(x = x, y = ourDates$Sub_metering_1,  type = "l", col = "black", ylab = "Energy Sub Metering")
lines(x = x, y = ourDates$Sub_metering_2,  type = "l", col = "red")
lines(x = x, y = ourDates$Sub_metering_3,  type = "l", col = "blue")
plot(x = x, y = ourDates$Global_reactive_power,  type = "l", col = "black", ylab = "GLobal Reactive Power")

# Save it as a PNG
dev.copy(png, "plot4.png")
dev.off()

