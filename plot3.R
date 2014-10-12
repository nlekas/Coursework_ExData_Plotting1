plot2 <- function(){
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
    data <- subset(data, Date_Time >= start, select=c(Date_Time, Sub_metering_1, Sub_metering_2, Sub_metering_3))
    data <- subset(data, Date_Time < end)
    
    ## Step 4: Build Plot
    ### Open PNG file
    png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")
    ### Create plot
    plot(data[,1], data[,2], ylab="Energy sub metering", type = "l", xlab = "")
    par(col="red")
    lines(data[,1],data[,3])
    par(col="blue")
    lines(data[,1],data[,4])
    par(col="black")
    legend("topright", lty=c(1,1), lwd=c(2.5, 2.5), col = c("black", "red","blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
    ### Close PNG file
    dev.off()
}
