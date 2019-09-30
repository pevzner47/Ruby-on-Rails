class CargoCar < Car

  def initialize(overall_volume)
    super('Cargo')
    @overall_volume = overall_volume
    validate!
  end

  def take_a_volume(value)
    @overall_volume -= value if @overall_volume >= value
  end

  private

  def validate!
    raise 'Ошибка ввода!' if @overall_volume !~ /^\d+$/
    @overall_volume = @overall_volume.to_i
  end
end
