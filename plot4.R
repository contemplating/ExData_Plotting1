#allData <- read.table("household_power_consumption.txt", sep=";", stringsAsFactors = F, header = T)
#energyData <- filter(allData, (Date == "1/2/2007") | (Date =="2/2/2007"))
#energyData <- mutate(energyData,  timepoint = dmy_hms(paste(Date, Time)))
#energyData <- mutate(energyData, Time = as.POSIXct(strptime(Time, "%H:%M:%S")))
#save(energyData, file="energyDate.DF")

#For performance reasons, I filtered the mean data and saved only the data needed for the plots. 
#Rhe code above was used to filter the data, but was only executed once

load("energyDate.DF")

energy <- energyData
energy <- mutate(energy, Global_active_power = as.numeric(Global_active_power))
energy <- mutate(energy, Global_reactive_power = as.numeric(Global_reactive_power))
energy <- mutate(energy, Voltage = as.numeric(Voltage))
energy <- mutate(energy, Global_intensity = as.numeric(Global_intensity))
energy <- mutate(energy, Sub_metering_1 = as.numeric( Sub_metering_1))
energy <- mutate(energy, Sub_metering_2 = as.numeric( Sub_metering_2))
energy <- mutate(energy, Sub_metering_3 = as.numeric( Sub_metering_3))

#plot 4
png(file="plot4.png",width=480,height=480)

par(mfrow = c(2,2))

plot(energy$timepoint,energy$Global_active_power, type="l", xlab = "", ylab="Global Active Power")

plot(energy$timepoint,energy$Voltage, type="l", xlab = "datetime", ylab="Voltage")

plot(energy$timepoint,energy$Sub_metering_1, type="l", xlab = "", ylab="Energy sub metering")
lines(energy$timepoint,energy$Sub_metering_2, type="l", col= "red")
lines(energy$timepoint,energy$Sub_metering_3, type="l", col= "blue")
legend("topright", legend  = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col= c("black","red","blue"), lwd=2)

plot(energy$timepoint,energy$Global_reactive_power, type="l", xlab = "datetime", ylab="Global_reactive_power")

dev.off()
