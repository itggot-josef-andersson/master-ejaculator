require_relative '../collectible'
require_relative '../../enums/options'
require_relative '../../enums/object_type'

class FirePowerUp < Collectible

  def initialize(x:0, y:0, destroy_time:(Time.now.to_f + Options::COLLECTIBLE_DESTROY_TIMER))
    super(type:ObjectType::FIRE_POWER_UP, x:x, y:y, destroy_time:destroy_time)

    @sprite = GameHandler.get_instance.get_sprite(sprite_id:SpriteID::FIRE_POWER_UP)
  end

  def collected(player:)
    puts 'ACTIVATE FIRE POWER UP'
  end

  def draw
    @sprite.draw_rot(@x, @y, ZOrder::ITEM, @angle, 0.5, 0.5, Options::COLLECTIBLE_SCALE, Options::COLLECTIBLE_SCALE)
  end

end