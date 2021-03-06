require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :capacity, :occupied_capacity, :free_capacity

  def initialize(capacity, type = 'cargo')
    @capacity, @free_capacity, @negative_capacity = capacity, capacity, capacity
    @occupied_capacity = 0
    super(type)
    validate!
  end

  def take_capacity(value)
    self.negative_capacity -= value
    validate!
    self.free_capacity -= value
    self.occupied_capacity += value
  end

  private

  attr_writer :capacity, :occupied_capacity, :free_capacity
  attr_accessor :negative_capacity


  def validate!
    super
    raise "Тип объема должен быть числовой, Вы указали = #{capacity.class}" if capacity.class != Integer
    raise "Нельзя создать вагон с объемом = #{capacity}" if capacity == 0
    raise "Превышен свободный объем = #{free_capacity}" if negative_capacity < 0
  end

end