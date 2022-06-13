# control princes fan
# 

class Princess
    var ser
    var statusFan
    var counter

    def init()
        self.ser = serial(3, 1, 115200, serial.SERIAL_8N1)
        self.statusFan = bytes("AAA00042")
        self.counter = 0
    end

    def every_second()
        self.counter += 1
        self.statusFan[3] = self.counter
        self.ser.write(self.statusFan)
    end
end

tasmota.add_driver(Princess())
