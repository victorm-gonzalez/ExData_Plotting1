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
dataSubset <- loadData()

png(filename="plot1.png", width=480, height=480, units="px")

hist(
    dataSubset$Global_active_power, 
    xlab="Global Active Power (kilowattts)", 
    main="Global Active Power",
    col="red")

dev.off()

