require_relative 'game_object'
require_relative '../j_tools'

class Alive < GameObject

  attr_accessor :max_health, :health

  def initialize(type:, x:0, y:0, vel_x:0, vel_y:0, vel_spin:0, angle:0, max_health:100)
    super(type:type, x:x, y:y, vel_x:vel_x, vel_y:vel_y, angle:angle, vel_spin:vel_spin)

    @max_health = max_health
    @health = max_health
  end

  def dead
    @health <= 0
  end

  def hit(damage:0)
    @health -= damage
  end

  def heal(health:@max_health)
    @health = JTools.clam(@health + health, 0, @max_health)
  end

end