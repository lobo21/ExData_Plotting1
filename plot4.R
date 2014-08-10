# Please, set the work directory before running the script

# Read the desired data and assign it to "df" object (subset: rows 66637 to 69517) 
df <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", header=FALSE, skip=66637, nrow=2880, colClasses=c(rep("character", 9)), sep=";")
labels <- names(read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", header=TRUE, nrow=1, sep=";"))
colnames(df) <- labels

# Convert "?" to "NA"
df[df=="?"] <- NA

# Set week days names to English format (original: Portuguese)
Sys.setlocale("LC_TIME", "English")

# Join columns "Date" and "Time" in a single column
df$Date.Time <- strptime(paste(df$Date,df$Time),"%d/%m/%Y %H:%M:%S")

# Delete "Date" and "Time" columns
df[1:2] <- list(NULL)

# Convert columns 1 to 7 to numbers
cols <- c(1:7)
df[,cols] = apply(df[,cols], 2, function(x) as.numeric(x))

# Set size and name of Plot 4
png(file="./plot4.png",width=480,height=480)

# Define the picture layout
par(mfrow=c(2,2))

# Plot "Plot 2" in row 1, column 1
plot(df$Date.Time, df$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")

# Plot "Additional Graph 1" in row 1, column 2
plot(df$Date.Time, df$Voltage, xlab="datetime", ylab="Voltage", type="l")

# Plot "Plot 3" in row 2, column 1
plot(df$Date.Time, df$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l")
lines(df$Date.Time, df$Sub_metering_2, xlab="", ylab="Global_active_power (kilowatts)", type="l", col="red")
lines(df$Date.Time, df$Sub_metering_3, xlab="", ylab="Global_active_power (kilowatts)", type="l", col="blue")
legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

# Plot "Additional Graph 2" in row 2, column 2
plot(df$Date.Time, df$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")

# Close graphic device
dev.off()
