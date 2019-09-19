class PassengerCar < Car
  attr_reader :type

  def initialize
    @type = 'Passenger'
  end
end
