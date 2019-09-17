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

  def number_of_typical_trains(type)
    @train_list.count {|train| train.type == type}
  end
end