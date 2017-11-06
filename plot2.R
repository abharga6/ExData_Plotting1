#getting file from the given url and unzipping the file 
if(!file.exists('data.zip')){ url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url,destfile = "data.zip")}
unzip("data.zip")

#Reading in the raw data
data <- read.table("household_power_consumption.txt",colClasses=c("character","character","numeric","numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), sep =";", header=TRUE, na.strings="?")

#concatenating data and time and creating a new variable 
data$datetime <- paste(data$Date,data$Time)

#striptime to change datetime format 
data$datetime<-strptime(data$datetime, "%d/%m/%Y %H:%M:%S")

#defining start and end point to get the desired dataset
start<-which(data$datetime==strptime("2007-02-01", "%Y-%m-%d"))
end<-which(data$datetime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))

#getting final dataset to work on 
data <- data[start:end,]

#Opening png device, plotting 2nd plot and closing the png device
png(file="plot2.png")
with(data, plot(datetime, Global_active_power, type="l", xlab="",ylab="Global Active Power (killowatts)"))
dev.off()





