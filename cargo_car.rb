class CargoCar < Car
  attr_reader :type
  def initialize
    super
    @type = 'Cargo' 
  end

  protected

  #attr_reader :type #в тз нет, используется в Train
end
