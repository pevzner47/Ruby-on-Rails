require_relative 'manufacturer'
require_relative 'validation'
class Car
  include Validation
  include Manufacturer
  attr_reader :type
  def initialize(type = nil, volume = 0)
    @type = type
    @volume = volume
    @taken_volume = 0
    validate!
    @volume = volume.to_i
  end

  def take_a_volume(value)
    if free_volume >= value
      @taken_volume += value
    end
  end

  def taken_volume
    @taken_volume
  end

  def free_volume
    @volume - @taken_volume
  end
end
