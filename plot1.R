# Please, set the work directory before running the script

# Read the data and assign it to "df" object
df <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", header=FALSE, skip=66637, nrow=2880, colClasses=c(rep("character", 9)), sep=";")
labels <- names(read.table("./exdata-data-household_power_consumption/household_power_consumption.txt", header=TRUE, nrow=1, sep=";"))
colnames(df) <- labels

# Convert "?" to "NA"
df[df=="?"] <- NA

# Join columns "Date" and "Time" in a single column
df$Date.Time <- strptime(paste(df$Date,df$Time),"%d/%m/%Y %H:%M:%S")

# Delete "Date" and "Time" columns
df[1:2] <- list(NULL)

# Convert columns 1 to 7 to numbers
cols <- c(1:7)
df[,cols] = apply(df[,cols], 2, function(x) as.numeric(x))

# Plot 1
png(file="./plot1.png",width=480,height=480)
hist(df$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)",col="red")
dev.off()