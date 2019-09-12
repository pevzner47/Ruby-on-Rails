class Train
  attr_reader :speed, :cars #Есть в тз => public

  def initialize(number)
    @number = number
    @speed = 0
    @route = nil
    @current_station_number = nil
    @cars = []
  end

  def increase_speed(value) #Есть в тз => public
    @speed += value
  end

  def decrease_speed(value) #Есть в тз => public
    @speed -= value if @speed - value >= 0
  end

  def add_car(car) #Есть в тз => public
    @cars << car if stopped? && @type == car.type
  end

  def delete_car(car) #Есть в тз => public
    @cars << car if stopped? && @type == car.type
  end

  def take_route(route) #Есть в тз => public
    @route = route
    @route.start_station.train_in(self)
    @current_station_number = 0
  end

  def move_forward #Есть в тз => public
    if !last_station?
      current_station.train_out(self)
      @current_station_number += 1
      current_station.train_in(self)
    end
  end

  def move_back #Есть в тз => public
    if !first_station?
      current_station.train_out(self)
      @current_station_number -= 1
      current_station.train_in(self)
    end
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
    current_station != @route.end_station
  end

  def first_station? #только тут 
    current_station != @route.start_station
  end

end

=begin
Класс Train (Поезд):
Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
--Может набирать скорость
--Может возвращать текущую скорость
--Может тормозить (сбрасывать скорость до нуля)
--Может возвращать количество вагонов
--Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
--Может принимать маршрут следования (объект класса Route). 
При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
--Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
--Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end