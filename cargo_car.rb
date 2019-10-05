require_relative 'validation'
class CargoCar < Car
  include Validation
  validate :volume, :format, /^\d+$/
  
  def initialize(volume)
    super('Cargo', volume)
  end
end
