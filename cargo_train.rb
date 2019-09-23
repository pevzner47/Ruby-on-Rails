class CargoTrain < Train
  
  include InstanceCounter
  def initialize(number)
    super(number, 'Cargo')
  end

  def add_car(car)
    super(car) if @type == car.type
  end
end
