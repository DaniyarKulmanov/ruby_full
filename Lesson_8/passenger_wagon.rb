require_relative 'wagon'

class PassengerWagon < Wagon

  attr_reader :seats, :occupied_seats, :free_seats

  def initialize(seats, type = 'passenger')
    @seats, @free_seats, @negative_seats = seats, seats, seats
    @occupied_seats = 0
    super(type)
    validate!
  end

  def take_seat(value)
    self.negative_seats -= value
    validate!
    self.free_seats -= value
    self.occupied_seats += value
  end

  private

  attr_writer :seats, :occupied_seats, :free_seats
  attr_accessor :negative_seats

  def validate!
    super
    raise "Места в вагоне должны быть числом, Вы указали = #{seats.class}" if seats.class != Integer
    raise "Места в вагоне не могут быть равны нулю, Вы указали = #{seats}" if seats == 0
    raise "Превышен лимит свобоных мест = #{free_seats}" if negative_seats < 0
  end

end