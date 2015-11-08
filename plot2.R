#Creates the SECOND plot of the assignment
plot2 <- function(){
  if(is.null(myData)){
    myData <- getData2()
  }
  plot(myData$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab="", x=myData$theDate)
}

#Gets a zip file from the internet, unzips it, loads one of the inner files and filters it given two dates
getData2 <- function(fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dataFile = "household_power_consumption.txt", begin = "1/2/2007", end = "2/2/2007"){
  temp <- tempfile()
  download.file(fileUrl,temp)
  data <- read.csv(unz(temp, dataFile),sep=";",na.strings = "?")
  data <- data[data$Date %in% c(begin, end),]
  #Creates column "theDate" as a Date column
  data$theDate <- strptime(paste(data$Date, data$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
  unlink(temp)
  data
}

png("plot2.png", bg=NA)
plot2()
dev.off()