#install a package for reading a subset of a table
if(!require(R.utils)) {
  install.packages("R.utils")
  require(R.utils)
}

#store working directory
setwd(choose.dir())
directory <- getwd()

#column classes
class <- c(rep("character",2),rep("numeric",7))

#creating index vector for importing a subset
days <- readTableIndex(paste(directory, "/household_power_consumption.txt", sep=""), indexColumn = 1, header=TRUE, sep=";")

#required dates
days2 <- c("01/02/2007")
days3 <- c("02/02/2007")

#comparison of dates
rows <- which(as.Date(days,format='%d/%m/%Y') == as.Date(days2,format='%d/%m/%Y'))
rows2 <- which(as.Date(days,format='%d/%m/%Y') == as.Date(days3,format='%d/%m/%Y'))

#subsetting vector - it stores the rownumbers for the rows needed
rows3 <- append(rows, rows2)

#read a subset by passing rows3
data <- readTable(paste(directory, "/household_power_consumption.txt", sep=""), rows=rows3, dec=".", sep=";",
                   header=T, colClasses = class, defColClass = "NULL", na.strings="?")

#use this line if you have non-English locale, remember to use the last line as well
#lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")

#change the dates from strings to proper format
data$datim <- paste(data$Date, data$Time)
data$datim <- strptime(data$datim, "%d/%m/%Y %H:%M:%S")

#open png device
png(file = "plot3.png", width = 480, height = 480)

#set number of columns and rows to 1
par(mfcol=c(1,1))

#draw the plot axes, box etc.
plot(data$datim, data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")

#draw the plot lines
lines(data$datim, data$Sub_metering_1, type="l", col="black")
lines(data$datim, data$Sub_metering_2, type="l", col="red")
lines(data$datim, data$Sub_metering_3, type="l", col="blue")

#draw the legend
legend("topright", lwd=0.1, col=c("black","red","blue"), legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), y.intersp=0.8, cex=0.9)

#close the device
dev.off()

#change locale back
#Sys.setlocale("LC_TIME", lct)
