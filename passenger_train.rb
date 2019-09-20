class PassengerTrain < Train 
  
  def initialize(number)
    super(number, 'Passenger')
  end

  def add_car(car)
    super(car) if @type == car.type
  end
end