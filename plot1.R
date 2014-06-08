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

#open png device
png(file = "plot1.png", width = 480, height = 480)

#set number of columns and rows to 1
par(mfcol=c(1,1))

#draw a histogram
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#close the device
dev.off()
