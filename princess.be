# control princes fan
# 

class princess
    var ser

    def init()
        self.ser = serial(3, 1, 115200, serial.SERIAL_8N1)
    end

    def every_second()
        # ser.write(bytes(203132))   # send binary 203132
        ser.write(bytes().fromstring("Hello\n"))   # send string "Hello"
    end


end

#myPrincess = princess()
tasmota.add_driver(myPrincess())



#msg = ser.read()   # read bytes from serial as bytes
#print(msg.asstring())   # print the message as string