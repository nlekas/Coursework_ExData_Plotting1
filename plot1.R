plot1 <- function(){
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
    data <- subset(data, Date_Time >= start, select=c(Date_Time, Global_active_power))
    data <- subset(data, Date_Time < end, select=c(Date_Time, Global_active_power))
    
    ## Step 4: Build Plot
    ### Open PNG file
    png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
    ### Create plot
    with(data, plot(hist(data[,2])))
    ### Edit plot
    plot(h, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
    title(main="Global Active Power")
    ### Close PNG file
    dev.off()
}
    