require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :capacity, :occupied_capacity, :free_capacity

  def initialize(capacity, type = 'cargo')
    @capacity, @free_capacity = capacity, capacity
    @occupied_capacity = 0
    super(type)
    validate!
  end

  def take_capacity(value)
    validate!
    self.free_capacity -= value
    self.occupied_capacity += value
  end

  private

  attr_writer :capacity, :occupied_capacity, :free_capacity


  def validate!
    super
    raise "Тип объема должен быть числовой, Вы указали = #{capacity.class}" if capacity.class != Integer
    raise "Нельзя создать вагон с объемом = #{capacity}" if capacity == 0
    raise "Свободный объем равен = #{free_capacity}" if free_capacity == 0
  end

end