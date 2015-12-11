require 'gosu'
require_relative 'alive'
require_relative '../handlers/game_handler'
require_relative '../enums/options'
require_relative '../enums/z_order'
require_relative '../j_tools'

class Player < Alive

  attr_accessor :ammo, :next_shot,
                :accelerating, :sprite,
                :move_acceleration_multiplier, :spin_acceleration_multiplier, :scale_multiplier

  def initialize(type:)
    super(type:type, max_health:Options::PLAYER_MAX_HEALTH)

    @animation_frames = GameHandler.get_instance.get_sprite(sprite_id:SpriteID::THRUST)
    if    type == ObjectType::PLAYER1 then @sprite = GameHandler.get_instance.get_sprite(sprite_id:SpriteID::PLAYER1)
    elsif type == ObjectType::PLAYER2 then @sprite = GameHandler.get_instance.get_sprite(sprite_id:SpriteID::PLAYER2) end

    @width  = @sprite.width
    @height = @sprite.height
  end

  ### Give ammo to the player
  def give_ammo(ammo:) @ammo = JTools::clam(@ammo + ammo, 0, 100) end

  ### Spin the player right or left
  def left()  @vel_spin -= Options::PLAYER_SPIN_ACCELERATION end
  def right() @vel_spin += Options::PLAYER_SPIN_ACCELERATION end

  def forward
    @vel_x += Gosu::offset_x(@angle, current_acceleration)
    @vel_y += Gosu::offset_y(@angle, current_acceleration)
    @accelerating = true
  end

  def backward
    @vel_x -= Gosu::offset_x(@angle, current_acceleration / 2.5)
    @vel_y -= Gosu::offset_y(@angle, current_acceleration / 2.5)
  end

  ### After multipliers are applied
  def current_scale()             Options::PLAYER_DEFAULT_SCALE * scale_multiplier                                 end
  def current_acceleration()      Options::PLAYER_ACCELERATION * move_acceleration_multiplier                      end
  def current_deceleration()      current_acceleration * 2.5                                                        end
  def current_spin_acceleration() Options::PLAYER_SPIN_ACCELERATION * spin_acceleration_multiplier                 end
  def current_spin_deceleration() current_spin_acceleration * 0.955                                                 end
  def current_hit_radius()        Math.sqrt((@width / 2 * current_scale) ** 2 + (@height / 2 * current_scale) ** 2) end

  def update
    ### Move and rotate
    @x += @vel_x; @y += @vel_y; @angle += @vel_spin

    ### Jump to the other side of the screen if outside the screen
    @x %= Options::GAME_WIDTH; @y %= Options::GAME_HEIGHT

    ### Decelerate movement and rotation
    @vel_spin *= current_spin_deceleration
    @vel_x    *= current_deceleration
    @vel_y    *= current_deceleration
  end

  ### Draws a ship and it's components at position
  def draw_ship(x:@x, y:@y, angle:@angle)
    @sprite.draw_rot(x, y, ZOrder::PLAYER, angle - 45, 0.5, 0.5, current_scale, current_scale)
    @animation_frame.draw_rot(x, y, ZOrder::PARTICLE, angle, 0.5, -3.5 * current_scale, current_scale, current_scale) if @accelerating
  end

  def draw
    @animation_frame = @animation_frames[Gosu::milliseconds / 100 % @animation_frames.size]

    draw_ship
    draw_ship(x:@x + Options::GAME_WIDTH) if @x < 23
    draw_ship(x:@x - Options::GAME_WIDTH) if @x > Options::GAME_WIDTH - 23
    draw_ship(y:@y + Options::GAME_HEIGHT) if @y < 23
    draw_ship(y:@y - Options::GAME_HEIGHT) if @y > Options::GAME_HEIGHT - 23
  end

end