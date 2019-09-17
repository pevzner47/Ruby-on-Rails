class Menu
    def car_creation (cars_arr, trains_arr) #создание вагона
    loop do
      puts 'Выберите тип вагона' #предложить выбрать тип вагона
      puts '1: Passenger'
      puts '2: Cargo'
      puts "0: Назад"
      key = gets.to_i 
      case key 
      when 1
        cars_arr << PassengerCar.new#по типу создаем вагон
        puts "Вагон создан!"
        break
      when 2
        cars_arr << CargoCar.new#по типу создаем вагон
        puts "Вагон создан!"
      when 0 
        break
      else
        puts "Ошибка ввода!"
        next
      end
    end
  end
end





















=begin #добавить вагон к поезду 
    if !trains_arr.empty? then #Если есть поезда
      puts 'Присоеденить его к поезду?'
      puts "Выберите действие:"
      puts "1: Да"
      puts "2: Нет"
      key = gets.to_i
      case key
      when 1 # демонстрация и выбор поездов
        puts 'Выберите поезд:'
        i = 0
        trains_arr.each { |train| puts "#{i += 1}: #{train.number}" }#показать все поезда с помощью цикла
        puts '0: Отмена'
        loop do #Цикл меню выбора поезда
          key = gets.to_i
          case key
          when 0..i # при верном выборе поезда добавляем
            trains_arr[key-1].add_car cars_arr.last
            puts 'Вагон добавлен!'
            break
          when 0 #выход из меню создания вагона
            break 
          else # ошибка выбора поезда
            puts "Ошибка ввода!"
            next
          end
        end
        break
      when 2
        break
      else # не да и не нет
        puts "Ошибка ввода!"
        next
      end
    end
  end
end
=end