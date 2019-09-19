class CargoCar < Car
  attr_reader :type

  def initialize
    super
    @type = 'Cargo' 
  end
end
