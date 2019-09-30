class PassengerCar < Car

  def initialize(number_of_seats)
    super('Passenger')
    @number_of_seats = number_of_seats
    validate!
  end

  def take_a_seat
    @number_of_seats -= 1 if @number_of_seats >= 1
  end

private

  def validate!
    raise 'Ошибка ввода!' if @number_of_seats !~ /^\d+$/
    @number_of_seats = @number_of_seats.to_i
  end
end
