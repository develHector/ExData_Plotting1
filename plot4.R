# Exploratory Data Analyisis.R
# Course Project 1
# Plot4.R - File who generates the corresponding plot from url <- 'data/household_power_consumption.txt' ;
# April 2014
# Hector Casavantes

# NOTE: My languaje locale is in non-english, weekdays will be seen in ok with this
Sys.setlocale("LC_ALL", "English")

# File supposed to be unzipped an placed under "data" subdirectory
url <- 'data/household_power_consumption.txt' ;

# Read the data directly on a Date format, just beware not to confuse variable for minutes with months (as I did)
library(Defaults)
setDefaults('as.Date.character', format = '%d/%m/%Y') ; 

# Since we will only be using data from the dates 2007-02-01 and 2007-02-02, read the data from just those dates 
myColClasses <- c( 'Date', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric' ) 
data <- subset( read.table( url, header=T, sep=';', nrows=2075259, na.strings = "?", colClasses = myColClasses ),
                complete.cases( Date ) & ( Date == as.Date( "1/2/2007" ) | Date == as.Date( "2/2/2007" ) ) ) ;

# As suggested, convert the  Time variable to Time class in R (Date was already done when reading)
# on this particular case, Im addint it as a new  column since the plots mandate it
data$DateTime <- strptime( paste( data$Date,data$Time ), format = "%F %T" )

# Plot 4 - Two of the previous graphs plus two time-sequenced global energy power and voltage measurements, all four in a single plot display
png( file = "plot4.png" )
par( mfcol = c(2,2) )
with( data, plot( DateTime, Global_active_power, type="l", ylab = "Global Active Power", xlab = "" ) )
with( data, {
  plot( DateTime, Sub_metering_1, type="l", ylab = "Energy Sub Metering", xlab = "", col="black" )
  lines( DateTime, Sub_metering_2, col = "red" )
  lines( DateTime, Sub_metering_3, col = "blue" )
  legend( "topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=c("solid","solid","solid"), col=c("black", "blue","red")) })
with( data, plot( DateTime, Voltage, type="l" ) )
with( data, plot( DateTime, Global_reactive_power, type="l" ) )
par( mfcol = c(1,1) )
dev.off()
