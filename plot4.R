#Creates the FOURTH plot of the assignment
plot4 <- function(){
  if(is.null(myData)){
    myData <- getData4()
  }
  #Set 2 x2 matrix for plotting
  old.par <-par(mfrow=c(2,2))
  
  #Top Left graph
  plot(myData$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab="", x=myData$theDate)
  
  #Top right graph
  plot(myData$Voltage,type="l", ylab = "Voltage", xlab="datetime", x=myData$theDate)

  #Bottom Left Graph
  plot(myData$Sub_metering_1,type="l", ylab = "Energy sub metering", xlab="", x=myData$theDate, ylim=c(0,max(myData$Sub_metering_1, myData$Sub_metering_2,myData$Sub_metering_3)))
  lines(myData$Sub_metering_2, x=myData$theDate,type = "l", col="red")
  lines(myData$Sub_metering_3, x=myData$theDate,type = "l", col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"),lwd=1, bty="n")
  
  #Bottom Right Graph
  plot(myData$Global_reactive_power,type="l", xlab="datetime", x=myData$theDate)
  
  par(old.par)
}

#Gets a zip file from the internet, unzips it, loads one of the inner files and filters it given two dates
getData4 <- function(fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dataFile = "household_power_consumption.txt", begin = "1/2/2007", end = "2/2/2007"){
  temp <- tempfile()
  download.file(fileUrl,temp)
  data <- read.csv(unz(temp, dataFile),sep=";",na.strings = "?")
  data <- data[data$Date %in% c(begin, end),]
  #Creates column "theDate" as a Date column
  data$theDate <- strptime(paste(data$Date, data$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
  unlink(temp)
  data
}

png("plot4.png", bg=NA)
plot4()
dev.off()