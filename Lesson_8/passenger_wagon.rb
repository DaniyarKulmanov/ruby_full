require_relative 'wagon'

class PassengerWagon < Wagon

  attr_reader :seats, :occupied_seats, :free_seats

  def initialize(seats, type = 'Passenger')
    super(type)
    @seats, @free_seats = seats, seats
    @occupied_seats = 0
    validate!
  end

  def take_seat
    validate!
    @free_seats -= 1
    @occupied_seats +=1
  end

  private

  attr_writer :seats, :occupied_seats, :free_seats

  def validate!
    super
    raise "Места в вагоне не могут быть равны нулю, Вы указали = #{seats}" if seats == 0
    raise "Нельзя больше занять места, свободные места = #{free_seats}" if free_seats == 0
  end

end