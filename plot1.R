plot1 <- function(){
      library(data.table)
      library(dplyr)
## Is data file in the working directory?
##  If not download and unzip it
      fileName="household_power_consumption.txt"
      if (!(fileName %in% list.files())) {
            download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power.zip", 
                          method=auto, quiet = FALSE, mode="wb")
            unzip("power.zip")
      }
##read it into R
      pwrTbl <- fread(fileName,na.strings="?")
## subset only 1/2/2007 and 2/2/2007      
      twodays <- filter(pwrTbl,Date=="1/2/2007"|Date=="2/2/2007")
##set plotting device to png file and create the requested histogram at 480 by 480 pixels
      png("plot1.png", width=480, height=480)
      hist(twodays$Global_active_power,col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
      dev.off()

}