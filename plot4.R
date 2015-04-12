########################################################
### LOAD THE DATA
########################################################
loadData <- function() {
    
    #Read the 5 first lines, to guess the class of each column
    dataTmp <- read.table("household_power_consumption.txt", 
                          header=TRUE, nrows=5, sep=";")
    
    #Extract the class of each column
    dataClasses <- sapply(dataTmp, class)
    
    #Read all the file, providing hints of classes and num of rows
    dataAll <- read.table("household_power_consumption.txt", 
                          header=TRUE, 
                          nrows=2075259, 
                          sep=";", 
                          colClasses = dataClasses,
                          na.strings = c("?"))
    
    #Subset the data to get only the desired dates
    dataSubset <- subset(dataAll, Date=='1/2/2007' | Date=='2/2/2007')
    
    #Create a new column with the datetime
    dataSubset$DateTime <- 
        strptime(
            paste(dataSubset[,1], dataSubset[,2], sep=" "),
            format='%d/%m/%Y %H:%M:%S')
    
    #return 
    dataSubset
}



########################################################
### GENERATE THE PLOT
########################################################

#This is to get the x-label in English
Sys.setlocale("LC_ALL","C")

dataSubset <- loadData()

png(filename="plot4.png", width=480, height=480, units="px")

par(mfrow=c(2,2))

#Graph of Global Active Power (top-left)
plot(dataSubset$DateTime, 
     dataSubset$Global_active_power, 
     ylab="Global Active Power", 
     xlab="", type="n")

lines(dataSubset$DateTime, 
      dataSubset$Global_active_power)

#Graph of voltage (top-right)
plot(dataSubset$DateTime, 
     dataSubset$Voltage, 
     ylab="Voltage", 
     xlab="datetime", 
     type="n")

lines(dataSubset$DateTime, dataSubset$Voltage)

#Graph of energy sub metering (bottom-left)
plot(dataSubset$DateTime, 
     dataSubset$Sub_metering_1, 
     ylab="Energy sub metering", 
     xlab="", 
     type="n")

lines(dataSubset$DateTime, dataSubset$Sub_metering_1, col="black")
lines(dataSubset$DateTime, dataSubset$Sub_metering_2, col="red")
lines(dataSubset$DateTime, dataSubset$Sub_metering_3, col="blue")

legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1, 1, 1), 
       col=c("black", "red", "blue"),
       bty="n")

#Graph of Global_reactive_power
plot(dataSubset$DateTime, 
      dataSubset$Global_reactive_power, 
      xlab="datetime", 
      ylab="Global_reactive_power",
      type="n")

lines(dataSubset$DateTime, dataSubset$Global_reactive_power)

dev.off()
