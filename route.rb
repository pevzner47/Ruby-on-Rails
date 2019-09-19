class Route
  attr_reader :stations

  def initialize(start_station, *station_list, end_station)
    @stations = [start_station] + station_list + [end_station]
  end

  def add_station(station) # Есть в тз => public
    @stations.insert(-2, station)
  end

  def delete_station(station) #Есть в тз => public
    @stations.delete(station) unless [start_station, end_station].include?(station)
  end

  def show_stations # Есть в тз => public
    @stations.each { |station| puts station.name }
  end

  def start_station
    @stations[0]
  end

  def end_station
    @stations[-1]
  end
end
