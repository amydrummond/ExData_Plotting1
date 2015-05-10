if(!dir.exists("./data")){dir.create("./data")}
if(!dir.exists("./data/exploratory_project_one")){dir.create("./data/exploratory_project_one")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./data/exploratory_project_one/data.zip")
unzip("./data/exploratory_project_one/data.zip", overwrite = TRUE, exdir="./data/exploratory_project_one")
setwd("./data/exploratory_project_one")
power_use <- read.table("household_power_consumption.txt", header = TRUE, stringsAsFactors = FALSE, sep = ";")


library(lubridate)
start <- ymd("2007-02-01")
end <- ymd("2007-02-02")

power_use$newdate <- dmy(power_use$Date)
power_use <- power_use[power_use$newdate >= start & power_use$newdate <= end,]

power_use$weekday <- wday(power_use$newdate, label = TRUE)
power_use$Global_active_power <- as.numeric(power_use$Global_active_power)
power_use$datetime <- ymd_hms(paste(power_use$newdate, " ", power_use$Time))
## Sometimes this line returns an error saying that it can't parse this; rerunning the line seems to cause it to work.
power_use$Sub_metering_1 <- as.numeric(power_use$Sub_metering_1)
power_use$Sub_metering_2 <- as.numeric(power_use$Sub_metering_2)
power_use$Sub_metering_3 <- as.numeric(power_use$Sub_metering_3)
power_use$Voltage <- as.numeric(power_use$Voltage)
power_use$Global_reactive_power <- as.numeric(Global_reactive_power)

png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
plot(power_use$datetime, power_use$Global_active_power, type = "n", ylab = "Global Active Power", xlab = '')
lines(power_use$datetime, power_use$Global_active_power)

plot(power_use$datetime, power_use$Voltage, type = "n",  ylab = "Voltage", xlab = 'datetime')
lines(power_use$datetime, power_use$Voltage)

plot(power_use$datetime, power_use$Sub_metering_1, type = "n", xlab = '', ylab = "Energy sub metering")
lines(power_use$datetime, power_use$Sub_metering_1, col = "black")
lines(power_use$datetime, power_use$Sub_metering_2, col = "red")
lines(power_use$datetime, power_use$Sub_metering_3, col = "blue")
legend("topright",lwd=c(2.5,2.5, 2.5),  bty = "n", cex=.9, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(power_use$datetime, power_use$Global_reactive_power, type = "n",  ylab = "Global_reactive_power", xlab = 'datetime')
lines(power_use$datetime, power_use$Global_reactive_power)
dev.off()
