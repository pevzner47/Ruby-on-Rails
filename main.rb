 require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'car'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'cargo_car'
require_relative 'menu'

cars_arr = []
stations_arr = []
trains_arr = []
routes_arr = []

menu = Menu.new cars_arr, trains_arr, stations_arr, routes_arr
menu.run