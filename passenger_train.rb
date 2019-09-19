class PassengerTrain < Train 
  attr_reader :type
  
  def initialize(number)
    super(number, 'Passenger')
  end

  def add_car(car)
    super(car) if @type == car.type
  end
end