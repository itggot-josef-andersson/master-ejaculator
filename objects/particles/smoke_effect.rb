require_relative '../particle'
require_relative '../../handlers/game_handler'
require_relative '../../enums/particle_id'
require_relative '../../enums/sprite_id'
require_relative '../../enums/z_order'

class SmokeEffect < Particle

  def initialize(x:0, y:0)
    super(type:ParticleID::SMOKE, x:x, y:y, animation_frames:GameHandler.get_instance.get_sprite(sprite_id:SpriteID::SMOKE_EFFECT))
  end

  def update
    animation_index >= @animation_frames.length
  end

  def draw
    @animation_frame = @animation_frames[animation_index]
    @animation_frame.draw_rot(@x, @y, ZOrder::PARTICLE, 0, 0.5, 0.5, 2, 2)
    puts "x:#{@x} y:#{@y} index:#{@index}"
  end

end