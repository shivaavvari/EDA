# import the required library
library(readr)
library(lubridate)
library(tidyr)
#import the dataset
household_power_consumption <- read_delim("household_power_consumption.txt", delim = ";", escape_double = FALSE, trim_ws = TRUE)

# create a dataframe
household_power_consumption <- data.frame(household_power_consumption,stringsAsFactors = FALSE)

# converting the Date column from character type to Date type
household_power_consumption$Date = as.Date(household_power_consumption$Date, format="%d/%m/%Y")
household_power_consumption$Date_time = paste(household_power_consumption$Date,household_power_consumption$Time)
household_power_consumption$Date_time = strptime(household_power_consumption$Date_time,format = " %Y-%m-%d %H:%M:%S" ,tz="EST ")



# creating a subset of Data for specific time  period
household_power_consumption_data <- subset(household_power_consumption, Date  > "2007-01-31"  & Date < "2007-02-03")
# convert the Global_active_power column to numeric if it is not already
household_power_consumption_data$Global_active_power = as.numeric(household_power_consumption_data$Global_active_power)


# open the Png device for saving plot3
png(filename="plot3.png",height=480,width=480)
#plot the Energy sub metering data
with(household_power_consumption_data,plot(Date_time,Sub_metering_1,type='n',ylab="Energy Sub Metering"))
with(household_power_consumption_data,points(Date_time,Sub_metering_1,type='l'))
with(household_power_consumption_data,points(Date_time,Sub_metering_2,type='l',col="red"))
with(household_power_consumption_data,points(Date_time,Sub_metering_3,type='l',col="blue"))
# insert a legend
legend("topright",pch=18,col=c('black','red','blue'),legend=c("Sub_metering_1","sub_metering_2","sub_metering_3"))
# close the device
dev.off()
