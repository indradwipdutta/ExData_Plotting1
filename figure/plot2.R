##plot2 for plot2.png
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

##Plot Global Active Power against Date
plot(PwrCons$Date,PwrCons$Global_active_power,type="l",xlab = "",ylab = "Global Active Power (kilowatts)",main="")

##copy and save the plot to a PNG file in WD
dev.copy(png,"plot2.png", width=480, height=480)##copy and save the plot to a PNG file in WD
dev.off()##close the PNG device
options("device")##set default Device as "RStudioGD"