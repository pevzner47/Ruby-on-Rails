class PassengerTrain < Train 

  def initialize(number)
    super
    @type = 'Passenger'
  end

protected

  attr_reader :type #в тз нет, используется в Train
end