require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'car'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'cargo_car'

def car_creation_menu (cars_arr, trains_arr)
  loop do
    puts 'Выберите тип вагона'
    puts '1: Passenger'
    puts '2: Cargo'
    puts "0: Назад"
    key = gets.to_i 
    case key 
    when 1
      cars_arr << PassengerCar.new
      puts "Вагон создан!"
      break
    when 2
      cars_arr << CargoCar.new
      puts "Вагон создан!"
    when 0 
      break
    else
      puts "Ошибка ввода!"
      next
    end
  end
end

def show_object_names (arr)
  i = 0
  arr.each { |obj| puts "#{i += 1}: #{obj.name}" }
end

def show_route_name(route)
  "#{route.stations[0].name} - #{route.stations[-1].name}"
end

def show_route_list(route_list)
  i = 0
  route_list.each { |route| puts "#{i += 1}: #{show_route_name (route)}"}
end

def train_creation_menu(trains_arr)
  puts "Введите номер поезда"
  number = gets.chomp.to_str
  puts "Выберите тип поезда"
  puts "1: Passenger"
  puts "2: Cargo"
  puts "3: Обычный"
  puts "0: Назад"
  loop do
    key = gets.to_i
    case key
    when 1
      trains_arr << PassengerTrain.new(number)
      puts "Поезд #{number} создан!"
      break
    when 2
      trains_arr << CargoTrain.new(number)
      puts "Поезд #{number} создан!"
      break
    when 3
      trains_arr << Train.new(number)
      puts "Поезд #{number} создан!"
      break
    when 0
      break
    else
      puts "Ошибка ввода!"
      next
    end
  end
end

def stations_creation_menu(stations_arr)
  puts 'Введите название станции'
  name = gets.chomp.to_str
  stations_arr << Station.new(name)
  puts "Станция #{name} создана!"
end

def routes_creation_menu(routes_arr, stations_arr)
  stations_to_show = [] + stations_arr
  if stations_arr.size < MINIMUM_NUMBER_OF_STATIONS then
    puts 'Недостаточно станций для создания маршрута'
    puts "Минимальное количество: #{MINIMUM_NUMBER_OF_STATIONS}"
  else
    loop do
      loop do
        puts 'Выберите начальную станцию маршрута'
        @start_station = false
        show_object_names(stations_to_show)
        puts ''
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
          puts "Ошибка ввода!"
          next
        end
      end
      if !!(@start_station) then
        puts 'Выберите конечную станцию'
        @end_station = false
        show_object_names(stations_to_show)
        loop do
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
            puts "Ошибка ввода!"
            next
          end
        end
      else
        puts 'Отмена создания маршрута'
        break
      end
      if !!@end_station then
        if stations_arr.size > MINIMUM_NUMBER_OF_STATIONS then 
          puts 'Выберите промезжуточные станции'
          @station_list = []
          loop do
          show_object_names(stations_to_show)
          puts "0: Назад"
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
              puts "Ошибка ввода!"
              next
            end
          end
        end
      else
        puts 'Отмена создания маршрута'
        break
      end
      routes_arr << Route.new(@start_station, @station_list, @end_station)
      puts 'Маршрут создан!'
      break
    end
  end
end

MINIMUM_NUMBER_OF_STATIONS = 2

cars_arr = []
stations_arr = []
trains_arr = []
routes_arr = []
=begin
nt = Train.new ('nt')
pt = PassengerTrain.new ('pt')
ct = CargoTrain.new ('ct')
stations_arr = []
stations_arr << Station.new('Moskva')
stations_arr << Station.new('Yaroslavl')
M_Y = Route.new stations_arr[0], stations_arr[1], stations_arr[2]
pcar1 = PassengerCar.new
pcar2 = PassengerCar.new
ccar1 = CargoCar.new
ccar2 = CargoCar.new
cars_arr = [pcar1, pcar2, ccar1, ccar2]
trains_arr = [nt, pt, ct]
routes_arr = [M_Y]
=end

def creation_menu (cars_arr, trains_arr, stations_arr, routes_arr)
  loop do
    puts "Выберите действие:"
    puts "1: Создать вагон"
    puts "2: Создать поезд"
    puts "3: Создать станцию"
    puts "4: Создать маршрут"
    puts "0: Выход"
    key = gets.to_i

    case key
    when 1
      car_creation_menu(cars_arr, trains_arr)
    when 2
      train_creation_menu(trains_arr)
    when 3 
      stations_creation_menu(stations_arr)
    when 4 
      routes_creation_menu(routes_arr, stations_arr)
    when 0 
      break
    else
      puts "Ошибка ввода!"
      next
    end
  end
end
 
def add_or_delete_station(route, stations_arr)
  loop do
    puts "1: Добавить станцию в маршрут #{show_route_name(route)}"
    puts "2: Удалить станцию из маршрута #{show_route_name(route)}"
    puts '0: Назад'
    key = gets.chomp.to_i
    case key 
    when 1
      loop do
        stations_to_add = stations_arr - route.stations
        if stations_to_add.empty? then
          puts 'Нечего добавлять'
          break
        else
          puts 'Какую станцию добавить'        
          show_object_names(stations_to_add)
          key = gets.chomp.to_i
          case key 
          when 1..stations_to_add.size
            route.add_station(stations_to_add[key])
            puts "Станция #{stations_to_add[key].name} добавлена" 
            break
          else 
            puts 'Ошибка ввода'
            next
          end
        end
      end
      break
    when 2
      loop do
        stations_to_delete = route.stations
        if stations_to_delete.size <= MINIMUM_NUMBER_OF_STATIONS
          puts 'Нечего удалять'
          break
        else
          puts 'Какую станцию удалить'
          show_object_names(stations_to_delete)
          key = gets.chomp.to_i
          case key 
          when 1..stations_to_delete.size
            route.delete_station(stations_to_delete[key])
            puts "Станция #{stations_to_delete[key].name} удалена" 
            break
          else 
            puts 'Ошибка ввода'
            next
          end
        end
      end
      break
    when 0
      break
    else 
      puts 'Ошибка ввода'
      next
    end
  end
end

def route_operation_menu(routes_arr, stations_arr)
  loop do
    puts 'Выберите маршрут'
    show_route_list(routes_arr)
    puts "0: Назад"
    key = gets.chomp.to_i
    case key
    when 1..stations_arr.size
      add_or_delete_station(routes_arr[key-1], stations_arr)
      break
    when 0
      break
    else
      puts "Ошибка ввода!"
      next
    end
  end
end

def show_train_numbers (trains_arr)
  i = 0
  trains_arr.each { |train| puts "#{i += 1}: #{train.number}"}
  puts "0: Назад"
end

def show_cars_type (cars_arr)
  i = 0
  cars_arr.each { |car| puts "#{i += 1}: #{car.type}"}
  puts "0: Назад"
end

def choose_route (routes_arr)
  puts 'Выберите маршрут'
  show_route_list (routes_arr)
  puts "0: Назад"
  loop do
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

def choose_train(trains_arr)
  puts 'Выберите поезд'
  show_train_numbers(trains_arr)
  loop do
    key = gets.to_i
    case key
    when 1..trains_arr.size
      return trains_arr[key-1]
    else 
      puts 'Ошибка ввода!'
      next
    end
  end
end

def choose_car(cars_arr)
  puts 'Выберите вагон'
  show_cars_type(cars_arr)
  loop do
    key = gets.to_i
    case key
    when 1..cars_arr.size
      return cars_arr[key-1]
    else 
      puts 'Ошибка ввода!'
      next
    end
  end
end

def choose_station (stations_arr)
  puts 'Выберите станцию'
  show_object_names(stations_arr)
    loop do
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

def show_train_list_of_this_station (station)
  if station.train_list.empty? then
    puts 'На станции еще нет поездов'
  else
    station.train_list.each {|train| puts train.number}
  end
end

def train_operation_menu (trains_arr, cars_arr, routes_arr)
  if trains_arr.empty? then
  return puts 'Ни одного поезда не найдено'
  else 
    puts '1: Добавить вагон'
    puts '2: Удалить вагон'
    puts '3: Взять маршрут'
    puts '4: Отправить по заданному маршруту'
    loop do 
      key = gets.to_i
      case key
      when 1
        puts key
        choose_train(trains_arr).add_car (choose_car(cars_arr))
        puts 'Вагон добавлен'
        break
      when 2
        choose_train(trains_arr).delete_car (choose_car(cars_arr))
        puts 'Вагон удален'
        break
      when 3
        choose_train(trains_arr).take_route(choose_route(routes_arr))
        puts 'Маршрут выбран!'
        break
      when 4
        @train = choose_train(trains_arr)
        if @train.route == nil then
          puts 'У этого поезда еще не задан маршрут'
          break
        else
          puts '1: Вперед по маршруту'
          puts '2: Назад по маршруту'
          puts '0: Назад'
          loop do
            key = gets.to_i
            case key
            when 1
              @train.move_forward
              break
            when 2
              @train.move_back
              break
            when 0 
              break
            else
              puts 'Ошибка ввода!'
              next
            end
          end
        end
      else  
        puts 'Ошибка ввода!'
        next
      end
      break
    end
  end
end

def station_operation_menu (stations_arr)
  puts '1: Показать все станции'
  puts '2: Показать список поездов на станции'
  puts '0: Назад'
  loop do
    key = gets.to_i
    case key
    when 1
      show_object_names(stations_arr)
      break
    when 2
      show_train_list_of_this_station (choose_station(stations_arr))
      break
    when 0
      break
    else 
      puts 'Ошибка ввода!'
      next
    end
  end
end

def operation_menu (cars_arr, trains_arr, stations_arr, routes_arr)
  puts 'Выберите объект'
  puts '1: Поезд'
  puts '2: Станция'
  puts '3: Маршрут'
  puts '0: Назад'
  loop do
    key = gets.to_i
    case key
    when 1
      train_operation_menu (stations_arr)
      break
    when 2
      station_operation_menu (stations_arr)
    when 3
      route_operation_menu routes_arr, stations_arr
    when 0 
      break
    else
      puts 'Ошибка ввода!'
      next
    end
  end
end

puts 'Вы в главном меню'
puts '1: Создать'
puts '2: Действия'
puts '0: Выход'
loop do
  key = gets.to_i
  case key
  when 1
    creation_menu cars_arr, trains_arr, stations_arr, routes_arr
    break
  when 2 
    operation_menu cars_arr, trains_arr, stations_arr, routes_arr
  when 0 
    break
  else
    puts 'Ошибка ввода!'
    next
  end
end
