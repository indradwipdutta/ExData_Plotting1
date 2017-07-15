##plot3 for plot3.png
##Read the text file
PwrCons<-read.table("household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?",colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

PwrCons <- PwrCons[complete.cases(PwrCons),]##take only the complete cases

PwrCons$Date<-as.Date(PwrCons$Date,"%d/%m/%Y")##convert character type date column to Dtae format
PwrCons$Time<-format(PwrCons$Time,format="%T")##convert character type time column to time format

##Filter out the Rows with Dates between 1st Feb 2007 to 2nd Feb 2007
PwrCons<-PwrCons[(PwrCons$Date>=as.Date("2007-2-1") & PwrCons$Date<=as.Date("2007-2-2")),]

PwrCons$Date<-paste(PwrCons$Date,PwrCons$Time)
PwrCons$Date<-as.POSIXct(PwrCons$Date)

## Remove Time column
PwrCons <- PwrCons[ ,colnames(PwrCons)!="Time"]

##Plot Global Active Power recorderd in submeter_1, against Date
plot(PwrCons$Date,PwrCons$Sub_metering_1,type="l",xlab = "",ylab = "Global Active Power (kilowatts)")

##Add Plots of Global Active Power recorderd in submeter_2, against Date
lines(PwrCons$Date,PwrCons$Sub_metering_2,type="l",col="red",xlab = "",ylab = "")

##Add Plots of Global Active Power recorderd in submeter_3, against Date
lines(PwrCons$Date,PwrCons$Sub_metering_3,type="l",col="blue",xlab = "",ylab = "")

##Define the legends of the overall Plot
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##copy and save the plot to a PNG file in WD
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()##close the PNG device
options("device")##set default Device as "RStudioGD"