class PassengerCar < Car
  attr_reader :type

  def initialize
    super('Passenger')
  end
end
