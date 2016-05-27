plot3 <- function(){
      library(data.table)
      library(dplyr)
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
      ##set plotting device to png file and create sub 1 plot at 480 by 480 pixels
      png("plot3.png", width=480, height=480)
      plot(date_time,twodays[,Sub_metering_1],xlab="",ylab="Energy sub metering", type="l")
      ## add lines for sub 2 and sub 3 in correct colors
      lines(date_time,twodays[,Sub_metering_2],col="red")
      lines(date_time,twodays[,Sub_metering_3],col="blue")
      ## create text and colors for legend and place legend in upper right
      leg_text=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
      leg_color <- c("black","red","blue")
      legend(x="topright",legend=leg_text,pt.,lwd=2, col=leg_color)
      dev.off()
}
