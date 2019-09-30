require_relative 'manufacturer'
require_relative 'valid'
class Car 
  include Manufacturer
  include Valid
  attr_reader :type
  
  def initialize(type = nil)
    @type = type
  end
end
