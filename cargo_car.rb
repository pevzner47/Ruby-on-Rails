class CargoCar < Car
  attr_reader :type

  def initialize
    super('Cargo')
  end
end
