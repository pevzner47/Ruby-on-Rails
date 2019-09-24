require_relative 'instance_counter'
class Station
  include InstanceCounter

  @@all_stations = []

  class << self
    def all
      @@all_stations
    end
  end
  attr_reader :train_list, :name

  def initialize(name)
    @name = name
    @train_list = []
    @@all_stations << self
    register_instance
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
end
