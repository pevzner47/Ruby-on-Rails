class PassengerTrain < Train 
  attr_reader :type
  
  def initialize(number, type = 'Passenger')
    super(number)
  end

  def add_car(car) #Есть в тз => public
    super(car) if @type == car.type
  end
end