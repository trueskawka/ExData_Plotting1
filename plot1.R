if(!require(R.utils)) {
  install.packages("R.utils")
  require(R.utils)
}

setwd(choose.dir())
directory <- getwd()

class <- c(rep("character",2),rep("numeric",7))
days <- readTableIndex(paste(directory, "/household_power_consumption.txt", sep=""), indexColumn = 1, header=TRUE, sep=";")
days2 <- c("01/02/2007")
days3 <- c("02/02/2007")
rows <- which(as.Date(days,format='%d/%m/%Y') == as.Date(days2,format='%d/%m/%Y'))
rows2 <- which(as.Date(days,format='%d/%m/%Y') == as.Date(days3,format='%d/%m/%Y'))
rows3 <- append(rows, rows2)

data <- readTable(paste(directory, "/household_power_consumption.txt", sep=""), rows=rows3, dec=".", sep=";",
                   header=T, colClasses = class, defColClass = "NULL", na.strings="?")

png(file = "plot1.png", width = 480, height = 480)

par(mfcol=c(1,1))

hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

dev.off()
