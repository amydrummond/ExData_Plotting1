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

###  PLOT 1

png(file = "plot1.png",width = 480, height = 480, units = "px")
hist(as.numeric(power_use$Global_active_power), main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()
