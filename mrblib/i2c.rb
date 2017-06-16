#
# Plato::I2C module
#
module Plato
  module I2C
    @@device = nil

    def self.register_device(device)
      @@device = device
    end

    def self.open(addr)
      raise "I2C device is not registered." unless @@device
      @@device.new(addr)
    end

    def read(reg, len, type=:as_array); end
    def write(reg, data); end
  end
end
