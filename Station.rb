class Station
attr_reader :train_list, :name

	def initialize(name)
		@name = name
		@train_list = []

	end

	def train_in(train)
		@train_list << train
	end

	def train_out(train)
		@train_list.delete(train)
	end

	def show_train_with_type
		number_freight = 0
		number_passenger = 0
		@train_list.each do |train|
			number_freight += 1 if train.type == "Freight"
			number_passenger += 1 if train.type == "Passenger"
			end
		puts "Number of freight trains: #{number_freight}"
		puts "Number of passenger trains: #{number_passenger}"
	end

end