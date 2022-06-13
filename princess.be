# control princes fan
# 

class princess
    var ser

    def init()
        self.ser = serial(3, 1, 115200, serial.SERIAL_8N1)
    end

    def every_second()
        ser.write(bytes().fromstring("Hello\n"))   # send string "Hello"
    end


end

#myPrincess = princess()
tasmota.add_driver(myPrincess())
