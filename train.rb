require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'valid'
class Train
  include InstanceCounter
  include Valid
  @@all_trains = {}
  class << self
    def find(str)
      @@all_trains[str]
    end
  end
  include Manufacturer 
  attr_reader :speed, :cars, :number, :route, :type

  def initialize(number, type = nil)
    @number = number 
    @speed = 0
    @route = nil
    @current_station_number = nil
    @cars = []
    @type = type
    validate!
    @@all_trains[self.number] = self
    register_instance
  end

  def increase_speed(value) #Есть в тз => public
    @speed += value
  end

  def decrease_speed(value) #Есть в тз => public
    @speed -= value if @speed - value >= 0
  end

  def add_car(car) #Есть в тз => public
    if stopped? then
      @cars << car if stopped?
    end
  end

  def delete_car(car) #Есть в тз => public
    if stopped? then 
      @cars.delete(car)
    end
  end

  def take_route(route) #Есть в тз => public
    @route = route
    route.stations[0].train_in(self)
    @current_station_number = 0
  end

  def move_forward #Есть в тз => public
    return if last_staion?
    current_station.train_out(self)
    @current_station_number += 1
    current_station.train_in(self)
  end

  def move_back #Есть в тз => public
    return if first_station?
    current_station.train_out(self)
    @current_station_number -= 1
    current_station.train_in(self)
  end

  def previous_station #Есть в тз => public
    @route.stations[@current_station_number - 1] if !first_station?
  end

  def current_station #Есть в тз => public
    @route.stations[@current_station_number]
  end

  def next_station #Есть в тз => public
    @route.stations[@current_station_number + 1] if !last_station?
  end

  def block_to_cars(&block)
    @cars.each_with_index {|car, index| yield(car, index)}
  end

  protected
  
  def stopped? #используется в дочерних классах
    @speed == 0
  end

  private 

  def last_station? #только тут
    current_station == @route.end_station
  end

  def first_station? #только тут 
    current_station == @route.start_station
  end

  def validate!
    raise 'Неверный формат номера' if @number !~ /^\w{3}-?\w{2}$/
  end
end
