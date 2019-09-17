class PassengerTrain < Train 

  def initialize(number)
    super
    @type = 'Passenger'
  end

  def add_car(car) #Есть в тз => public
    @cars << car if stopped? && @type == car.type
  end

  protected

  attr_reader :type #в тз нет, используется в Train
end