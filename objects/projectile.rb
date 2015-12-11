require_relative 'game_object'

class Projectile < GameObject

  attr_reader :sender, :width, :height

  def initialize(type:, sender:, x:0, y:0, vel_x:0, vel_y:0, angle:0, vel_spin:0)
    super(type:type, x:x, y:y, vel_x:vel_x, vel_y:vel_y, angle:angle, vel_spin:vel_spin)

    ### Just for reference
    @width = @height = @scale = 0

    @sender = sender
  end

  ### Hmm...
  def hit_radius() @width * @scale / 2 end

end