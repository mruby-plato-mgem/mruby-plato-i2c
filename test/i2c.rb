# Plato::I2C module

class I
  def initialize(addr)
    @addr = addr
  end
  def read(reg, len, type=:as_array)
    case type
    when :as_array
      return [0] * len
    when :as_string
      return "\0" * len
    end
  end
  def write(reg, data); data; end
end

assert('I2C', 'class') do
  assert_equal(Plato::I2C.class, Module)
end

assert('I2C', 'register_device') do
  Plato::I2C.register_device(I)
end

assert('I2C', 'open') do
  Plato::I2C.register_device(I)
  Plato::I2C.open(0)
end

assert('I2C', 'open - argument error') do
  Plato::I2C.register_device(I)
  assert_raise(ArgumentError) {Plato::I2C.open}
  assert_raise(ArgumentError) {Plato::I2C.open(1, 2)}
end

assert('I2C', 'open - no deivce') do
  Plato::I2C.register_device(nil)
  assert_raise(RuntimeError) {Plato::I2C.open(1)}
end

assert('I2C', 'read') do
  Plato::I2C.register_device(I)
  i2c = Plato::I2C.open(0)
  assert_equal(i2c.read(0, 1), [0])
  assert_equal(i2c.read(0, 4, :as_array), [0, 0, 0, 0])
  assert_equal(i2c.read(0, 2, :as_string), "\0\0")
end

assert('I2C', 'read - argument error') do
  Plato::I2C.register_device(I)
  i2c = Plato::I2C.open(0)
  assert_raise(ArgumentError) {i2c.read}
  assert_raise(ArgumentError) {i2c.read(0)}
  assert_raise(ArgumentError) {i2c.read(0, 0, :as_array, 0)}
end

assert('I2C', 'write') do
  Plato::I2C.register_device(I)
  i2c = Plato::I2C.open(0)
  i2c.write(0, [1, 2, 3])
  i2c.write(0, "\0\1\2")
end
