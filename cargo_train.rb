class CargoTrain < Train 

  def initialize(number)
    super
    @type = 'Cargo'

  end

protected

  attr_reader :type #в тз нет, используется в Train
end