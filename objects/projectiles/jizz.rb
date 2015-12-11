require_relative '../projectile'
require_relative '../../enums/z_order'
require_relative '../../enums/sprite_id'

class Jizz < Projectile

  def initialize(type:, sender:, x:0, y:0, vel_x:0, vel_y:0, angle:0, scale:(Options::NORMAL_JIZZ_SCALE))
    super(type:type, sender:sender, x:x, y:y, vel_x:vel_x, vel_y:vel_y, angle:angle)
    @scale = scale
    @animation_frames = GameHandler.get_instance.get_sprite(sprite_id:SpriteID::NORMAL_JIZZ)
    @width  = @animation_frames[0].width
    @height = @animation_frames[0].height
  end

  def update
    @x += @vel_x
    @y += @vel_y

    true if @x < 0 - @width / 2 || @x > Options::GAME_WIDTH + @width / 2 || @y < 0 - @height / 2 || @y > Options::GAME_HEIGHT + @height / 2
  end

  def draw
    @animation_frame = @animation_frames[Gosu::milliseconds / 100 % @animation_frames.size]
    @animation_frame.draw_rot(@x, @y, ZOrder::PROJECTILE, @angle, 0.5, 0.5, @scale, @scale)
  end

end