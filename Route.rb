class Route
attr_reader :start_station, :end_station, :station_list

	def initialize (start_station, inter_station_list = [], end_station)
		@start_station = start_station
		@inter_station_list = inter_station_list
		@end_station = end_station
		@station_list = [@start_station] + @inter_station_list + [@end_station]
	end

	def add_station (station)
		@inter_station_list << station
		@station_list = [@start_station] + @inter_station_list + [@end_station]
	end

	def delete_station (station)
		@inter_station_list.delete(station) if (station != @start_station && station != @end_station)
		@station_list = [@start_station] + @inter_station_list + [@end_station]
	end

	def show_stations
		@station_list.each {|station| puts station.name}
	end

end