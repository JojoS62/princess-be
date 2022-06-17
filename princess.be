# control princes fan
# 

import webserver

class Princess
    var ser
    var statusFan
    var counter
    var status_power

    def init()
        if gpio.pin(gpio.TXD) != -1 && gpio.pin(gpio.RXD) != -1
            self.ser = serial(gpio.pin(gpio.RXD), gpio.pin(gpio.TXD), 115200, serial.SERIAL_8N1)
            self.statusFan = bytes("AAA00042")
            self.counter = 0
            self.status_power = 0

            tasmota.add_driver(self)
            tasmota.add_cmd('Fan', /cmd, idx, payload, payload_json -> self.fan_cmd_handler(cmd, idx, payload, payload_json))
            print("Princess driver added")
        else
            raise 'assert_failed',  'serial is not configured, define Serial_RxD and Serial_TxD'
        end
    end


    def every_100ms()
        if self.ser.available() >= 4
            var rBuf = self.ser.read()
            var id = rBuf.get(0, 2)
            print("hello5")
#            mqtt.publish("Fan01", rBuf.tostring())
        end
    end

    def fan_cmd_handler(cmd, idx, payload, payload_json)
        print("fan_cmd_handler")

        # parse payload
        if payload_json != nil && payload_json.find("power") != nil 
            self.status_power = int(payload_json.find("power"))
            print("found power")
            self.ser.write(self.statusFan)
        end

        # report the command as successful
        tasmota.resp_cmnd_done()
    end

      #- create a method for adding a button to the main menu -#
    def web_add_main_button()
        webserver.content_send("<p></p><button onclick='la(\"&m_toggle_main=1\");'>Toggle Main</button>")
    end

    def kill()
        tasmota.remove_driver(self)
        tasmota.remove_cmd('Fan')
        print("Princess driver removed")
    end

end

p.kill() 

p=Princess()
