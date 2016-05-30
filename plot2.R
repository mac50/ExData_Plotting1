plot2 <- function(){
      library(data.table)
      library(dplyr)
     ##testing drag and drop
      ## Is data file in the working directory?
      ##  If not download and unzip it
      fileName="household_power_consumption.txt"
      if (!(fileName %in% list.files())) {
            download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power.zip", 
                          method="auto", quiet = FALSE, mode="wb")
            unzip("power.zip")
      }
      ##read it into R
      pwrTbl <- fread(fileName,na.strings="?")
      ## subset only 1/2/2007 and 2/2/2007      
      twodays <- filter(pwrTbl,Date=="1/2/2007"|Date=="2/2/2007")
      ## convert data and time strings to a single  POSIXlt variable
      date_time <-strptime( paste (twodays[,Date],twodays[,Time]," "),"%d/%m/%Y %H:%M:%S")
      ##set plotting device to png file and create the requested plot at 480 by 480 pixels
      png("plot2.png", width=480, height=480)
      plot(date_time,twodays[,Global_active_power],xlab="",ylab="Global Active Power (kilowatts)", type="l")
      dev.off()
}
           