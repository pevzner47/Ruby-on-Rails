require_relative 'modules'

class Car 
  include Manufacturer
  attr_reader :type
  
  def initialize(type = nil)
    @type = type
  end
end
