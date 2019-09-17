class Station
  attr_reader :train_list, :name #есть в ТЗ = public

  #name убрать

  def initialize(name)
    @name = name
    @train_list = []
  end

  def train_in(train) #Есть в тз => public
    @train_list << train
  end

  def train_out(train) #Есть в тз => public
    @train_list.delete(train)
  end

  def number_of_typical_trains(type) #Есть в тз => public
    @train_list.count {|train| train.type == type}
  end

  protected
  #attr_reader :name # Нет в ТЗ, но используется в route => protect 

end

=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end
