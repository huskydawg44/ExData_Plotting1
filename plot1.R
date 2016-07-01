# Make Plot 1 in Exploratory Data Analysis Course Project 1

# Load data from file
hpc<-read.table("household_power_consumption.txt",header = TRUE,sep = ";",
                na.strings = "?",colClasses = c(rep("character",2),rep("numeric",7)))

# Identify rows with the 2 dates for plotting and merge them with a logical OR command
saverows1<-hpc$Date=="1/2/2007"
saverows2<-hpc$Date=="2/2/2007"
saverows<-saverows1|saverows2

# Filter data to only the 2 days we are interested in.
hpc2<-hpc[saverows,]

# Open PNG graphics device
png(filename = "plot1.png",width = 480, height = 480)

# Make Plot 1, which is a histogram of Global Active Power over the 2 days.
hist(hpc2$Global_active_power,main = "Global Active Power",
     xlab = "Gobal Active Power (kilowatts)",col = "red")

# Export the plot to file by closing the PNG graphics device
dev.off()