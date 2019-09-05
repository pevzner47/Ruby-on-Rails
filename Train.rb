class Train #10

attr_accessor :speed #2,3
attr_reader :cars_number, :type #5


	def initialize(number, type, cars_number) #1
		@number = number
		@type = type
		@cars_number = cars_number
		@speed = 0
		@route = nil
		@current_station_number = nil
	end

	def stop #4
		@speed = 0
	end

	def add_car #6
		@cars_number += 1 if @speed == 0
	end

	def delete_car
		@cars_number -= 1 if (@speed == 0 && @cars_number > 0)
	end
	
	def take_route(route) #7
		@route = route
		@route.start_station.train_in(self) #8 slojno.!!!
		@current_station_number = 0
	end

	def move(where)
		@route.station_list[@current_station_number].train_out(self)
		case 
		when "forward"
			@current_station_number += 1 if @route.end_station != @route.station_list[@current_station_number]

		when "back"
			@current_station_number -= 1 if @route.end_station != @route.station_list[@current_station_number]	

		else 
			puts "wrong way"
		end
		@route.station_list[@current_station_number].train_in(self)
	end

	def route_status
		puts "Previous station is #{@route.station_list[@current_station_number - 1].name}" if @current_station_number != 0
		puts "Current station is #{@route.station_list[@current_station_number].name}"
		puts "Next station is #{@route.station_list[@current_station_number + 1].name}" if @current_station_number != (@route.station_list.size - 1)

	end

end