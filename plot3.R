if(!require(R.utils)) {
  install.packages("R.utils")
  require(R.utils)
}

setwd(choose.dir())
directory <- getwd()

##lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")

class <- c(rep("character",2),rep("numeric",7))
days <- readTableIndex(paste(directory, "/household_power_consumption.txt", sep=""), indexColumn = 1, header=TRUE, sep=";")
days2 <- c("01/02/2007")
days3 <- c("02/02/2007")
rows <- which(as.Date(days,format='%d/%m/%Y') == as.Date(days2,format='%d/%m/%Y'))
rows2 <- which(as.Date(days,format='%d/%m/%Y') == as.Date(days3,format='%d/%m/%Y'))
rows3 <- append(rows, rows2)

data <- readTable(paste(directory, "/household_power_consumption.txt", sep=""), rows=rows3, dec=".", sep=";",
                  header=T, colClasses = class, defColClass = "NULL", na.strings="?")

data$datim <- paste(data$Date, data$Time)
data$datim <- strptime(data$datim, "%d/%m/%Y %H:%M:%S")

png(file = "plot3.png", width = 480, height = 480)

par(mfcol=c(1,1))

plot(data$datim, data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(data$datim, data$Sub_metering_1, type="l", col="black")
lines(data$datim, data$Sub_metering_2, type="l", col="red")
lines(data$datim, data$Sub_metering_3, type="l", col="blue")
legend("topright", lwd=0.1, col=c("black","red","blue"), legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), y.intersp=0.8, cex=0.9)

dev.off()

##Sys.setlocale("LC_TIME", lct)