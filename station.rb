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
    validate!(name)
  end

  def train_in(train)
    @train_list << train
  end

  def train_out(train)
    @train_list.delete(train)
  end

  def number_of_typical_trains(type)
    @train_list.count {|train| train.type == type}
  end

  protected

  def validate!(name)
    raise 'Название станции не должно быть пустым' if name !~ /^\w+/
  end

  def valid?(name)
    validate!(name)
    true
  rescue
    false
  end
end
