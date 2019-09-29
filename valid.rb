module Valid

protected

  def valid?
    validate!
    true
  rescue
    false
  end
end