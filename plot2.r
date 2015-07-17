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
png("plot2.png", width = 480, height = 480, units = "px", bg = "white")
par(mar= c(4, 4, 2, 1))

plot(data1[,"Global_active_power"],type="l",xaxt = 'n', ylab="Global Active Power (kilowatts)", xlab="")
axis(side=1,loc,xlabel)

dev.off()