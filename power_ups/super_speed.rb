require_relative 'power_up'
require_relative '../enums/options'
require_relative '../enums/power_up_id'

class SuperSpeed < PowerUp

  attr_accessor :speed

  def initialize(player:, time:Options::SUPER_SPEED_TIME + Time.now.to_f, speed:Options::SUPER_SPEED_MULTIPLIER)
    @speed = speed
    super(time:time, player:player, type:PowerUpID::SUPER_SPEED)
  end

  def enable
    puts '   Gotta go fast!'
    @player.move_acceleration_multiplier = @speed
  end

  def disable
    @player.move_acceleration_multiplier = 1
  end

end