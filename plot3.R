#Creates the THIRD plot of the assignment
plot3 <- function(){
  if(is.null(myData)){
    myData <- getData3()
  }
  plot(myData$Sub_metering_1,type="l", ylab = "Energy sub metering", xlab="", x=myData$theDate, ylim=c(0,max(myData$Sub_metering_1, myData$Sub_metering_2,myData$Sub_metering_3)))
  lines(myData$Sub_metering_2, x=myData$theDate,type = "l", col="red")
  lines(myData$Sub_metering_3, x=myData$theDate,type = "l", col="blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"),lwd=1)
}

#Gets a zip file from the internet, unzips it, loads one of the inner files and filters it given two dates
getData3 <- function(fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dataFile = "household_power_consumption.txt", begin = "1/2/2007", end = "2/2/2007"){
  temp <- tempfile()
  download.file(fileUrl,temp)
  data <- read.csv(unz(temp, dataFile),sep=";",na.strings = "?")
  data <- data[data$Date %in% c(begin, end),]
  #Creates column "theDate" as a Date column
  data$theDate <- strptime(paste(data$Date, data$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
  unlink(temp)
  data
}

png("plot3.png", bg=NA)
plot3()
dev.off()