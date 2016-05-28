plot4 <- function(){
      library(data.table)
      library(dplyr)
      ## Is data file in the working directory?
      ##  If not download and unzip it
      fileName="household_power_consumption.txt"
      if (!(fileName %in% list.files()))  {
            download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power.zip", 
                          method="auto", quiet = FALSE, mode="wb")
            unzip("power.zip")
      }      
            
      ##read it into R
      pwrTbl <- fread(fileName,na.strings="?")
      ## subset only 1/2/2007 and 2/2/2007      
      twodays <- filter(pwrTbl,Date=="1/2/2007"|Date=="2/2/2007")
      ## convert data and time strings to a single  POSIXlt variable
      datetime <-strptime( paste (twodays[,Date],twodays[,Time]," "),"%d/%m/%Y %H:%M:%S")
      ##set plotting device to png file and set for 4 plots in 480 by 480 pixels
      png("plot4.png", width=480, height=480)
      old.par <- par(mfrow=c(2, 2))
      ## place Global Active Power vs.Time plot at R1C1
      plot(datetime,twodays[,Global_active_power],xlab="",ylab="Global Active Power (kilowatts)", type="l")
      ## place voltage versus time at R1,C2
      with(twodays,plot(datetime,Voltage,type="l"))
      #place plot with three sub Metering values at R2,C1
      plot(datetime,twodays[,Sub_metering_1],xlab="",ylab="Energy sub metering", type="l")
      ## add lines for sub 2 and sub 3 in correct colors
      lines(datetime,twodays[,Sub_metering_2],col="red")
      lines(datetime,twodays[,Sub_metering_3],col="blue")
      ##add slightly smaller legend without box
      leg_text=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
      leg_color <- c("black","red","blue")
      legend(x="topright",legend=leg_text,pt.,lwd=1, col=leg_color,bty="n",cex=.8)
      ## place plot of reactive power versus time at R2,C2
      with(twodays,plot(datetime,Global_reactive_power,type="l"))
      par(old.par) ## not really needed since shutting off device
      dev.off()
}