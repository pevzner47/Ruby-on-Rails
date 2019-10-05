require_relative 'validation'
class CargoTrain < Train
  include Validation
  include InstanceCounter
  validate :number, :format, /^\w{3}-?\w{2}$/
  
  def initialize(number)
    super(number, 'Cargo')
  end

  def add_car(car)
    super(car) if @type == car.type
  end
end
