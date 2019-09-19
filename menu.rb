class Menu

  def initialize
    @cars_arr = []
    @trains_arr = []
    @stations_arr = []
    @routes_arr = []
  end

  def run 
    loop do
      message_main_menu
      key = gets.to_i
      case key
      when 1
        creation_menu
      when 2 
        operation_menu
      when 0 
        break
      else
        puts MESSAGE_INPUT_ERROR
        next
      end
    end
  end

  private
  
  #message
  MESSAGE_INPUT_ERROR = "Ошибка ввода!"
  MESSAGE_CAR_CREATED = "Вагон создан!"
  MESSAGE_TRAINS_ARR_EMPTY ='Ни одного поезда не найдено'
  MESSAGE_TRAIN_HAS_NO_ROUTE = 'У этого поезда еще не задан маршрут'
  MINIMUM_NUMBER_OF_STATIONS = 2

  private_constant :MESSAGE_INPUT_ERROR, :MESSAGE_CAR_CREATED, :MESSAGE_TRAINS_ARR_EMPTY, :MESSAGE_TRAIN_HAS_NO_ROUTE, :MINIMUM_NUMBER_OF_STATIONS

  def message_in_car_creation_menu
    puts 'Выберите тип вагона'
    puts '1: Passenger'
    puts '2: Cargo'
    puts "0: Назад"
  end

  def message_in_train_creation_menu
    puts "Выберите тип поезда"
    puts "1: Passenger"
    puts "2: Cargo"
    puts "3: Обычный"
    puts "0: Назад"
  end

  def  message_in_creation_menu
    puts "Выберите действие:"
    puts "1: Создать вагон"
    puts "2: Создать поезд"
    puts "3: Создать станцию"
    puts "4: Создать маршрут"
    puts "0: Выход"
  end

  def message_out_of_stations
    puts 'Недостаточно станций для создания маршрута'
    puts "Минимальное количество: #{MINIMUM_NUMBER_OF_STATIONS}"
  end

  def message_in_station_operation_menu
    puts '1: Показать все станции'
    puts '2: Показать список поездов на станции'
    puts '0: Назад'
  end

  def message_in_choose_route(routes_arr)
    puts 'Выберите маршрут'
    show_route_list (routes_arr)
    puts "0: Назад"
  end

  def message_in_intermediate_station_selection(stations_to_show)
    puts 'Выберите промезжуточные станции'
    show_object_names(stations_to_show)
    puts "0: Назад"
  end

  def message_in_train_operation_menu
    puts '1: Добавить вагон'
    puts '2: Удалить вагон'
    puts '3: Взять маршрут'
    puts '4: Отправить по заданному маршруту'
  end

  def message_in_route_operation_menu
    puts 'Выберите маршрут'
    show_route_list(@routes_arr)
    puts "0: Назад"
  end

  def message_in_operation_menu
    puts 'Выберите объект'
    puts '1: Поезд'
    puts '2: Станция'
    puts '3: Маршрут'
    puts '0: Назад'
  end

  def message_main_menu
    puts 'Вы в главном меню'
    puts '1: Создать'
    puts '2: Действия'
    puts '0: Выход'
  end

  def message_direction_selection
    puts '1: Вперед по маршруту'
    puts '2: Назад по маршруту'
    puts '0: Назад'
  end
  #creation menu
    #car
  def create_passenger_car
    @cars_arr << PassengerCar.new
    puts MESSAGE_CAR_CREATED
  end 

  def create_cargo_car
    @cars_arr << CargoCar.new
    puts MESSAGE_CAR_CREATED
  end

  def car_creation_menu
    loop do
      message_in_car_creation_menu
      key = gets.to_i 
      case key 
      when 1
        create_passenger_car
        break
      when 2
        create_cargo_car
        break
      when 0 
        break
      else
        puts MESSAGE_INPUT_ERROR
        next
      end
    end
  end
  #creation menu
    #train
  def create_passenger_train(number)
    @trains_arr << PassengerTrain.new(number)
    puts "Поезд #{number} создан!"
  end

  def create_cargo_train(number)
    @trains_arr << CargoTrain.new(number)
    puts "Поезд #{number} создан!"
  end

  def create_simple_train(number)
    @trains_arr << Train.new(number)
    puts "Поезд #{number} создан!"
  end

  def train_creation_menu
    puts "Введите номер поезда"
    number = gets.chomp.to_str
    loop do      
      message_in_train_creation_menu
      key = gets.to_i
      case key
      when 1
        create_passenger_train(number)
        break
      when 2
        create_cargo_train(number)
        break
      when 3
        create_simple_train(number)
        break
      when 0
        break
      else
        puts MESSAGE_INPUT_ERROR
        next
      end
    end
  end

  def stations_creation_menu
    puts 'Введите название станции'
    name = gets.chomp.to_str
    @stations_arr << Station.new(name)
    puts "Станция #{name} создана!"
  end
#routes
  def show_object_names (arr)
    i = 0
    arr.each { |obj| puts "#{i += 1}: #{obj.name}" }
  end

  def start_station_selection(stations_to_show)
    loop do
      puts 'Выберите начальную станцию маршрута'
      @start_station = false
      show_object_names(stations_to_show)
      key = gets.to_i
      case key
      when 1..stations_to_show.size
        @start_station = stations_to_show[key-1]
        stations_to_show.delete(@start_station)
        break
      when 0
        puts "0: Назад"
        break
      else
        puts MESSAGE_INPUT_ERROR
        next
      end
    end
  end

  def end_station_selection(stations_to_show)
    @end_station = false
    loop do
      puts 'Выберите конечную станцию'
      show_object_names(stations_to_show)
      key = gets.to_i
      case key
      when 1..stations_to_show.size
        @end_station = stations_to_show[key-1]
        stations_to_show.delete(@end_station)
        break
      when 0
        puts "0: Назад"
          break
      else
        puts MESSAGE_INPUT_ERROR
        next
      end
    end
  end

  def intermediate_station_selection(stations_to_show)
    if @stations_arr.size > MINIMUM_NUMBER_OF_STATIONS then 
      loop do
        @station_list = []
        message_in_intermediate_station_selection(stations_to_show)
        key = gets.to_i
        case key
        when 1..stations_to_show.size
          @station_list << stations_to_show[key-1]
          stations_to_show.delete(stations_to_show[key-1])
          if !stations_to_show.empty?
            next
          else
            break
          end
        when 0
          break
        else
          puts MESSAGE_INPUT_ERROR
          next
        end
      end
    end
  end

  def routes_creation_menu
    stations_to_show = [] + @stations_arr
    if @stations_arr.size < MINIMUM_NUMBER_OF_STATIONS then
      return message_out_of_stations
    end
    loop do
      start_station_selection(stations_to_show)
      if !!(@start_station) then
        end_station_selection(stations_to_show)
      else
        puts 'Отмена создания маршрута'
        break
      end
      if !!@end_station then
        intermediate_station_selection(stations_to_show)
      else
        puts 'Отмена создания маршрута'
        break
      end
      @routes_arr << Route.new(@start_station, @station_list, @end_station)
      puts 'Маршрут создан!'
      break
    end
  end

  #operations
    #route
  def show_route_name(route)
    "#{route.stations[0].name} - #{route.stations[-1].name}"
  end

  def message_in_add_or_delete_station(route)
    puts "1: Добавить станцию в маршрут #{show_route_name(route)}"
    puts "2: Удалить станцию из маршрута #{show_route_name(route)}"
    puts '0: Назад'
  end

  def show_route_list(route_list)
    i = 0
    route_list.each { |route| puts "#{i += 1}: #{show_route_name(route)}"}
  end

  def choose_station
    loop do
      puts 'Выберите станцию'
      show_object_names(stations_arr)
      key = gets.to_i
      case key
      when 1..stations_arr.size
        return stations_arr[key-1]
      else 
        puts 'Ошибка ввода!'
        next
      end
    end
  end

  def routes_operation_add_station(route)
    loop do
      stations_to_add = @stations_arr - route.stations
      if stations_to_add.empty? then
        puts 'Нечего добавлять'
        break
      end
      puts 'Какую станцию добавить'        
      show_object_names(stations_to_add)
      key = gets.chomp.to_i
      case key 
      when 1..stations_to_add.size
        route.add_station(stations_to_add[key-1])
        puts "Станция #{stations_to_add[key-1].name} добавлена" 
        break
      else 
        puts 'Ошибка ввода'
        next
      end
    end
  end

  def routes_operation_delete_station(route)
    loop do
      stations_to_show = route.stations[1...-1]
      if stations_to_show.empty?
        puts 'Нечего удалять'
        break
      end
      puts 'Какую станцию удалить'
      show_object_names(stations_to_show)
      key = gets.chomp.to_i
      case key 
      when 1..stations_to_show.size
        route.delete_station(stations_to_show[key-1])
        puts "Станция #{stations_to_show[key-1].name} удалена" 
        break
      else 
        puts 'Ошибка ввода'
        next
      end
    end
  end

  def add_or_delete_station(route)
    loop do
      message_in_add_or_delete_station(route)
      key = gets.chomp.to_i
      case key 
      when 1
        routes_operation_add_station(route)
        break
      when 2
        routes_operation_delete_station(route)
        break
      when 0
        break
      else 
        puts 'Ошибка ввода'
        next
      end
    end
  end

  def route_operation_menu
    loop do
      message_in_route_operation_menu
      key = gets.chomp.to_i
      case key
      when 1..@stations_arr.size
        add_or_delete_station(@routes_arr[key-1])
        break
      when 0
        break
      else
        puts "Ошибка ввода!"
        next
      end
    end
  end
  #station
  def choose_station
    loop do
      puts 'Выберите станцию'
      show_object_names(@stations_arr)
      key = gets.to_i
      case key
      when 1..@stations_arr.size
        return @stations_arr[key-1]
      else 
        puts 'Ошибка ввода!'
        next
      end
    end
  end

  def show_train_list_of_this_station (station)
    if station.train_list.empty? then
      return puts 'На станции еще нет поездов'
    end
    station.train_list.each {|train| puts train.number}
  end

  def station_operation_menu
    loop do
      message_in_station_operation_menu
      key = gets.to_i
      case key
      when 1
        show_object_names(@stations_arr)
        break
      when 2
        show_train_list_of_this_station (choose_station)
        break
      when 0
        break
      else 
        puts 'Ошибка ввода!'
        next
      end
    end
  end
  #train
  def show_train_numbers
    i = 0
    @trains_arr.each { |train| puts "#{i += 1}: #{train.number}"}
    puts "0: Назад"
  end

  def show_cars_type(cars)
    i = 0
    cars.each { |car| puts "#{i += 1}: #{car.type}"}
    puts "0: Назад"
  end

  def choose_route (routes_arr)
    loop do
      message_in_choose_route(routes_arr)
      key = gets.to_i
      case key
      when 1..routes_arr.size
        return routes_arr[key-1]
      else 
        puts 'Ошибка ввода!'
        next
      end
    end
  end

  def choose_train
    loop do
      puts 'Выберите поезд'
      show_train_numbers
      key = gets.to_i
      case key
      when 1..@trains_arr.size
        return @trains_arr[key-1]
      else 
        puts 'Ошибка ввода!'
        next
      end
    end
  end

  def choose_car (cars)
    loop do
      puts 'Выберите вагон'
      show_cars_type (cars)    
      key = gets.to_i
      case key
      when 1..cars.size
        return cars[key-1]
      else 
        puts 'Ошибка ввода!'
        next
      end
    end
  end

  def train_operation_add_car
    train = choose_train
    cars_to_show = @cars_arr - train.cars
    train.add_car (choose_car(cars_to_show))
    puts 'Вагон добавлен'
  end

  def train_operation_delete_car
    train = choose_train
    cars_to_show = train.cars
    train.delete_car (choose_car(cars_to_show))
    puts 'Вагон удален'
  end

  def train_operation_send_train
    train = choose_train
    if train.route == nil then
      return puts MESSAGE_TRAIN_HAS_NO_ROUTE
    end
    message_direction_selection
    loop do
      key = gets.to_i
      case key
      when 1
        train.move_forward
        break
      when 2
        train.move_back
        break
      when 0 
        break
      else
        puts 'Ошибка ввода!'
        next
      end
    end
  end

  def train_operation_menu
    if @trains_arr.empty? then
      return puts MESSAGE_TRAINS_ARR_EMPTY
    end
    loop do 
      message_in_train_operation_menu
      key = gets.to_i
      case key
      when 1
        train_operation_add_car
        break
      when 2
        train_operation_delete_car
        break
      when 3
        choose_train.take_route(choose_route (@routes_arr))
        puts 'Маршрут выбран!'
        break
      when 4
        train_operation_send_train
      else  
        puts 'Ошибка ввода!'
        next
      end
      break
    end
  end 

  def creation_menu
    loop do
      message_in_creation_menu
      key = gets.to_i
      case key
      when 1
        car_creation_menu
        break
      when 2
        train_creation_menu
        break
      when 3 
        stations_creation_menu
        break
      when 4 
        routes_creation_menu
        break
      when 0 
        break
      else
        puts MESSAGE_INPUT_ERROR
        next
      end
    end
  end

  def operation_menu
    loop do
      message_in_operation_menu
      key = gets.to_i
      case key
      when 1
        train_operation_menu
        break
      when 2
        station_operation_menu
      when 3
        route_operation_menu
      when 0 
        break
      else
        puts 'Ошибка ввода!'
        next
      end
    end
  end
end
