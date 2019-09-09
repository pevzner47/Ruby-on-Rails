class Train
  attr_reader :cars_number, :type

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
    @route.station_list[@current_station_number].train_out(self)
    @current_station_number += 1 if @route.end_station != @route.station_list[@current_station_number]
    @route.station_list[@current_station_number].train_in(self)
    end

  def move_back
    @route.station_list[@current_station_number].train_out(self)
    @current_station_number -= 1 if @route.end_station != @route.station_list[@current_station_number]
    @route.station_list[@current_station_number].train_in(self)
    end

  def previous_station
    return @route.station_list[@current_station_number - 1].name if @current_station_number != 0
    end

  def current_station
    @route.station_list[@current_station_number].name
     end

  def next_station
    return @route.station_list[@current_station_number + 1].name if @current_station_number != (@route.station_list.size - 1)
   end
end