class Route
  attr_reader :station_list

  def initialize(start_station, *station_list, end_station)
    @station_list = [start_station] + station_list + [end_station]
  end

  def start_station
    return @station_list[0] 
  end

  def end_station
    return @station_list[-1]
  end

  def add_station(station)
    @station_list << @station_list[-1]
    @station_list[-2] = station
  end

  def delete_station(station)
    @station_list.delete(station) if station != @station_list[0] && station != @station_list[-1]
  end

  def show_stations
    @station_list.each { |station| puts station.name }
  end
end