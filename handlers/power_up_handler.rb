require_relative '../enums/power_up_id'
require_relative '../enums/options'
require_relative '../power_ups/super_speed'

class PowerUpHandler

  attr_accessor :active_power_ups

  def initialize
    @active_power_ups = []
  end

  def get_active_power_up(player:, power_up_id:)
    @active_power_ups.each do |power_up|
      if power_up.player.type == player.type && power_up.type == power_up_id
        return power_up
      end
    end
    nil
  end

  def activate_power_up(player:, power_up_id:)
    existing = get_active_power_up(player:player, power_up_id:power_up_id)
    if power_up_id == PowerUpID::SUPER_SPEED
      if existing != nil
        existing.time = Time.now.to_f + Options::SUPER_SPEED_TIME
      else
        @active_power_ups << SuperSpeed.new(player:player)
      end
    end
  end

  def deactivate_power_up(power_up:)
    @active_power_ups.delete(power_up)
    power_up.disable
  end

  def update
    @active_power_ups.each do |power_up|
      if power_up.old
        power_up.disable
        @active_power_ups.delete(power_up)
        puts 'DEACTIVATED A POWER UP'
      end
    end
  end

end