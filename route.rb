class Route
  attr_reader :stations #УБРАТЬ

  def initialize(start_station, *station_list, end_station)
    @stations = [start_station] + station_list + [end_station]
  end

  def add_station(station) # Есть в тз => public
    @stations.insert(-2, station)
  end

  def delete_station(station) #Есть в тз => public
    @station_list.delete(station) unless [start_station, end_station].include?(station)
  end

  def show_stations # Есть в тз => public
    @stations.each { |station| puts station.name }
  end

  #protected  спрятать в протект

  #attr_reader :stations # в тз нет, но используется в train => protected

  def start_station # В ТЗ нет, но используется тут и в train => protected
    @stations[0]
  end

  def end_station # В ТЗ нет, но используется тут и в train => protected
    @stations[-1]
  end
end

=begin
Класс Route (Маршрут):
Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end
