class CargoTrain < Train 
  attr_reader :type
  
  def initialize(number, type = 'Cargo')
    super(number)
  end

  def add_car(car)
    super(car) if @type == car.type
  end
end
