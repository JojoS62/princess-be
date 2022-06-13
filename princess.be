# control princes fan
# 

class Princess
    var ser
    var statusFan
    var counter

    def init()
        if gpio.pin(gpio.TXD) != -1 && gpio.pin(gpio.RXD) != -1
            self.ser = serial(gpio.pin(gpio.RXD), gpio.pin(gpio.TXD), 115200, serial.SERIAL_8N1)
            self.statusFan = bytes("AAA00042")
            self.counter = 0
        else
            print("serial is not configured, define Serial_RxD and Serial_TxD\n")
        end
    end

    def every_second()
        if self.ser == nil
            return
        end
        self.counter += 1
        self.statusFan[3] = self.counter
        self.ser.write(self.statusFan)
    end

    def every_100ms()
        if self.ser == nil
            return
        end

        if self.ser.available() >= 4
            self.statusFan = self.ser.read()
            self.ser.write(self.statusFan)
        end
    end
end

tasmota.add_driver(Princess())
