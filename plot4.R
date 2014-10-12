plot4 <- function(){
    ## This function is for linux operating systems only.
    ## This function assumes you unzipped the data into the working directory
    ## into a folder named data.
    
    require(plyr)
    library(plyr)
    
    ## STEP 1: Read Data
    data <- read.table("data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings ="?")
    
    ## STEP 2: Format Date/Time Columns
    data <- mutate(data, Date_Time = strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
    
    ## STEP 3: Subset data for plot
    start <- as.POSIXct("2007-02-01 00:00:00")
    end <- as.POSIXct("2007-02-03 00:00:00")
    data <- subset(data, Date_Time >= start)
    data <- subset(data, Date_Time < end)

    ## Step 4: Build Plot
    ### Open PNG file
    png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
    par(mfrow=c(2,2))
    
    ### Create 1st plot
    plot(data[,10], data[,3], ylab="Global Active Power (kilowatts)", type = "l", xlab = "")
    
    ## Create 2nd plot
    plot(data[,10], data[,5], ylab="Voltage", type = "l", xlab = "datetime")
    
    ## Create 3rd plot
    plot(data[,10], data[,7], ylab="Energy sub metering", type = "l", xlab = "")
    par(col="red")
    lines(data[,10],data[,8])
    par(col="blue")
    lines(data[,10],data[,9])
    par(col="black")
    legend("topright", lty=c(1,1), lwd=c(2.5, 2.5), col = c("black", "red","blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
    
    ## Create 4th plot
    plot(data[,10], data[,4], ylab="Voltage", type = "l", xlab = "datetime")
    
    
    ### Close PNG file
    dev.off()
}
