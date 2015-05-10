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
## Turns out this is unnecessary, but I left it anyway.
power_use$Global_active_power <- as.numeric(power_use$Global_active_power)
power_use$datetime <- ymd_hms(paste(power_use$newdate, " ", power_use$Time))
## Sometimes this datetime code says it can't parse. But running the same line again seems to get it to work. 
png(file = "plot2.png", width = 480, height = 480, units = "px")
plot(power_use$datetime, power_use$Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = '')
lines(power_use$datetime, power_use$Global_active_power)
dev.off()
