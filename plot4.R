# Make Plot 4 in Exploratory Data Analysis Course Project 1

# Load data from file
hpc<-read.table("household_power_consumption.txt",header = TRUE,sep = ";",
                na.strings = "?",colClasses = c(rep("character",2),rep("numeric",7)))

# Identify rows with the 2 dates for plotting and merge them with a logical OR command
saverows1<-hpc$Date=="1/2/2007"
saverows2<-hpc$Date=="2/2/2007"
saverows<-saverows1|saverows2

# Filter data to only the 2 days we are interested in.
hpc2<-hpc[saverows,]

# Put the Date and Time variables into a single column
hpc3<-paste(hpc2$Date,hpc2$Time,sep=" ")

# Load lubridate for use in date parsing
library(lubridate)

# Use the lubridate function parse_date_time to convert the text into POSIXct format
hpc4<-parse_date_time(hpc3,orders = "dmyhms")

# Open PNG graphics device
png(filename = "plot4.png",width = 480, height = 480)

# Configure plotting to make 2x2 grid of plots
par(mfcol = c(2, 2))

## Generate Upper left plot
# Make a linegraph of Global Active Power over the 2 days.
plot(hpc4,hpc2$Global_active_power,type="l",xlab="",
     ylab = "Global Active Power (kilowatts)")

## Generate Lower Left plot 
# Make a 3 line graph of Sub_metering 1-3. First add sub_metering1
plot(hpc4,hpc2$Sub_metering_1,type="l",xlab="",
     ylab = "Energy sub metering")

# Add submetering2
points(hpc4,hpc2$Sub_metering_2,type="l",col="red")

# Add submetering3
points(hpc4,hpc2$Sub_metering_3,type="l",col="blue")

# Add legend
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"),inset = 0.01,
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),box.col="white")

## Generate Upper right plot
# Make a linegraph of Voltage over the 2 days.
plot(hpc4,hpc2$Voltage,type="l",xlab="datetime",
     ylab = "Voltage")

## Generate Lower right plot
# Make a linegraph of Global_Reactive_Power over the 2 days.
plot(hpc4,hpc2$Global_reactive_power,type="l",xlab="datetime",
     ylab="Global_reactive_power")

# Export the plot to file by closing the PNG graphics device
dev.off()