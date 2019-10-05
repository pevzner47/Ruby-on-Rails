require_relative 'validation'
class PassengerCar < Car
  include Validation
  validate :volume, :format, /^\d+$/
  
  def initialize(number_of_seats)
    super('Passenger', number_of_seats)
  end

  def take_a_volume
    super(1)
  end
end
