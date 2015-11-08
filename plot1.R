#Creates the FIRST plot of the assignment
plot1 <- function(){
  if(is.null(myData)){
    myData <- getData()
  }
  hist(myData$Global_active_power, col="red", main ="Global Active Power", xlab="Global Active Power (kilowats)")
}

#Gets a zip file from the internet, unzips it, loads one of the inner files and filters it given two dates
getData <- function(fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dataFile = "household_power_consumption.txt", begin = "1/2/2007", end = "2/2/2007"){
  temp <- tempfile()
  download.file(fileUrl,temp)
  data <- read.csv(unz(temp, dataFile),sep=";",na.strings = "?")
  data <- data[data$Date %in% c(begin, end),]
  unlink(temp)
  data
}

png("plot1.png", bg=NA)
plot1()
dev.off()