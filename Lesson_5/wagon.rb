class Wagon
  attr_reader :manufacturer, :open_locks

  def initialize(manufacturer)
    @manufacturer = manufacturer
    close_doors
  end

  def open_doors
    self.open_locks = true
  end

  def close_doors
    self.open_locks = false
  end

  private

  attr_writer :open_locks

end