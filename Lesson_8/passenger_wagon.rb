require_relative 'wagon'

class PassengerWagon < Wagon

  attr_reader :seats, :occupied_seats, :free_seats

  def initialize(seats, type = 'passenger')
    @seats, @free_seats = seats, seats
    @occupied_seats = 0
    super(type)
    validate!
  end

  def take_seat(value)
    validate!
    self.free_seats -= value
    self.occupied_seats += value
  end

  private

  attr_writer :seats, :occupied_seats, :free_seats

  def validate!
    super
    raise "Места в вагоне должны быть числом, Вы указали = #{seats.class}" if seats.class != Integer
    raise "Места в вагоне не могут быть равны нулю, Вы указали = #{seats}" if seats == 0
    raise "Нельзя больше занять места, свободные места = #{free_seats}" if free_seats == 0
  end

end