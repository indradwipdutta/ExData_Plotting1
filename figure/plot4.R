##plot1 for plot1.png
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

##Set the Screen space for ploting 4 plots
par(mfrow=c(2,2))

##I--Plot Global Active Power against Date
plot(PwrCons$Date,PwrCons$Global_active_power,type="l",xlab = "",ylab = "Global Active Power")

##II--Plot of Voltage, against Date
plot(PwrCons$Date,PwrCons$Voltage,type="l",xlab = "datetime",ylab = "Voltage")

##III--Add Combined Submetering Plots , against Date
##Plot of submeter_1, against Date
plot(PwrCons$Date,PwrCons$Sub_metering_1,type="l",xlab = "",ylab = "Enerygy sub metering")

##Add Plot of  submeter_2, against Date
lines(PwrCons$Date,PwrCons$Sub_metering_2,type="l",col="red",xlab = "",ylab = "")

##Add Plot of submeter_3, against Date
lines(PwrCons$Date,PwrCons$Sub_metering_3,type="l",col="blue",xlab = "",ylab = "")

##Define the legends of the overall Plot
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


##IV--Plot of Global Reactive Power, against Date
plot(PwrCons$Date,PwrCons$Global_reactive_power,type="l",xlab = "datetime",ylab = "Global_reactive_power")


dev.copy(png,"plot4.png", width=480, height=480)##copy and save the plot to a PNG file in WD
dev.off()##close the PNG device
options("device")##set default Device as "RStudioGD"