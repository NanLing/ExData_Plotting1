temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",header=T, na.strings = "?")
unlink(temp)

D1<-as.matrix(droplevels(split(data,data$Date,drop=TRUE)$'1/2/2007'))
D2<-as.matrix(droplevels(split(data,data$Date,drop=TRUE)$'2/2/2007'))
data1<-rbind(D1,D2)
colnames = dimnames(data1)[[2]]

plotdate<-c("1/2/2007","2/2/2007","3/2/2007")
loc <- unlist(lapply(expand.grid(plotdate), function(x) match(x,data1[,"Date"])))
loc[length(loc)]<- length(data1[,"Date"])+1
xlabel <- strtrim(weekdays(as.Date(plotdate,"%d/%m/%Y")),3)
png("plot4.png", width = 480, height = 480, units = "px", bg = "white")

par(mfrow=c(2,2))
plot(data1[,"Global_active_power"],type="l",xaxt = 'n', ylab="Global Active Power", xlab="")
axis(side=1,loc,xlabel)
plot(data1[,"Voltage"],type="l",xaxt = 'n', ylab="Voltage", xlab = "datetime")
axis(side=1,loc,xlabel)
plot(data1[,"Sub_metering_1"],type="l",xaxt = 'n', ylab="Energy sub metering", xlab="")
lines(data1[,"Sub_metering_2"],col="red")
lines(data1[,"Sub_metering_3"],col="blue")
axis(side=1,loc,xlabel)
legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"), yjust=1, bty="n")
plot(data1[,"Global_reactive_power"],type="l",xaxt = 'n', ylab="Global_reactive_power", xlab = "datetime")
axis(side=1,loc,xlabel)

dev.off()