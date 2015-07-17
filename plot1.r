temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",header=T, na.strings = "?")
unlink(temp)

D1<-as.matrix(droplevels(split(data,data$Date,drop=TRUE)$'1/2/2007'))
D2<-as.matrix(droplevels(split(data,data$Date,drop=TRUE)$'2/2/2007'))
data1<-rbind(D1,D2)
colnames = dimnames(data1)[[2]]
png("plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar= c(4, 4, 2, 1))
hist(as.numeric(data1[,"Global_active_power"]), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()