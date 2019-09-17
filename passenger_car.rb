class PassengerCar < Car
  attr_reader :type

  def initialize
    super
    @type = 'Passenger'
  end

protected

  #attr_reader :type #в тз нет, используется в Train
end
