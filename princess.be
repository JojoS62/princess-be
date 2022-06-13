# control princes fan
# 

class Princess
    var ser
    var statusFan

    def init()
        self.ser = serial(3, 1, 115200, serial.SERIAL_8N1)
        self.statusFan = bytes("AAA00042")
    end

    def every_second()
        self.ser.write(self.statusFan)
    end
end

tasmota.add_driver(Princess())
