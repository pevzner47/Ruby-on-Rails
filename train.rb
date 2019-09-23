require_relative 'modules'
class Train
  include InstanceCounter
  @@all_trains = []
  class << self
    def find(str)
      arr = @@all_trains.find_all {|train| train.number == str}
      return nil if arr == []
      arr[0]
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
    @@all_trains << self
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
      puts 'Вагон добавлен'    
    end
  end

  def delete_car(car) #Есть в тз => public
    if stopped? then 
      @cars.delete(car)
      puts 'Вагон удален'
    end
  end

  def take_route(route) #Есть в тз => public
    @route = route
    route.stations[0].train_in(self)
    @current_station_number = 0
  end

  def move_forward #Есть в тз => public
    if last_station?
      return puts "Невозможно отправить поезд вперед!"
    end
    current_station.train_out(self)
    @current_station_number += 1
    current_station.train_in(self)
    puts "Поезд отправлен на станцию #{current_station.name}"
  end

  def move_back #Есть в тз => public
    if first_station?
      return puts "Невозможно отправить поезд назад!"
    end
    current_station.train_out(self)
    @current_station_number -= 1
    current_station.train_in(self)
    puts "Поезд отправлен на станцию #{current_station.name}"
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

end
