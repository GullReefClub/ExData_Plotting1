# plot2.png

# Clear all existing objects
rm(list = ls())

# Read the text file into a data frame
df <- read.table("household_power_consumption.txt", stringsAsFactors = TRUE, header = TRUE, sep = ";")

# Replace "?" with NA
df[ df == "?" ] = NA

# Subset to the two dates we care about. No need for data conversion here.
ourDates <- subset(df, (Date == "1/2/2007"| Date == "2/2/2007"))

# We do need a data conversion for the Global_active_power attribure.
ourDates$Global_active_power <- as.numeric(as.character(ourDates$Global_active_power))

#Get the datetimes for the plot
x <- with(ourDates, as.POSIXct(paste(as.Date(Date, format="%d/%m/%y"), Time)))

#Subset to Global_active
y = ourDates$Global_active_power

#make the plot 
plot(x,y,type = "l", col = 'blue', ylab = "Global Active Power (in kilowatts)")

# Save it as a PNG
dev.copy(png, "plot2.png")
dev.off()

