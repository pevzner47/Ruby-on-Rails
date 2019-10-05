require_relative 'instance_counter'
require_relative 'accessor'
require_relative 'validation'
class Station
  include Validation
  include InstanceCounter
  @@all_stations = []

  class << self
    def all
      @@all_stations
    end
  end
  attr_reader :train_list, :name
  validate :name, :presence

  def initialize(name)
    @name = name
    validate!
    @train_list = []
    @@all_stations << self
    register_instance
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

  def block_to_trains(&block)
    @train_list.each {|train| yield(train)}
  end
end
