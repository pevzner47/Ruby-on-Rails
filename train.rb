class Train
  attr_reader :cars_number, :type, :speed

  def initialize(number, type, cars_number)
    @number = number
    @type = type
    @cars_number = cars_number
    @speed = 0
    @route = nil
    @current_station_number = nil
  end

  def increase_speed(value)
    @speed += value
  end

  def decrease_speed(value)
    @speed -= value if @speed - value >= 0
  end

  def add_car
    @cars_number += 1 if @speed == 0
  end

  def delete_car
    @cars_number -= 1 if @speed == 0 && @cars_number > 0
  end

  def take_route(route)
    @route = route
    @route.start_station.train_in(self)
    @current_station_number = 0
  end

  def move_forward
    if next_station
      current_station.train_out(self)
      @current_station_number += 1
      self.current_station.train_in(self)
    end
  end

  def move_back
    if previous_station
      self.current_station.train_out(self)
      @current_station_number -= 1
      self.current_station.train_in(self)
    end
  end

  def previous_station
    @route.stations[@current_station_number - 1] if current_station != @route.start_station
  end

  def current_station
    @route.stations[@current_station_number]
  end

  def next_station
    @route.stations[@current_station_number + 1] if current_station != @route.end_station
  end
end