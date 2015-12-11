require_relative '../collectible'
require_relative '../../enums/options'
require_relative '../../enums/object_type'
require_relative '../../enums/scene_id'
require_relative '../../enums/power_up_id'
require_relative '../../enums/sprite_id'
require_relative '../../handlers/game_handler'

class SuperSpeedPowerUp < Collectible

  def initialize(x:0, y:0, destroy_time:(Time.now.to_f + Options::COLLECTIBLE_DESTROY_TIMER))
    super(type:ObjectType::SUPER_SPEED_POWER_UP, x:x, y:y, destroy_time:destroy_time)

    @sprite = GameHandler.get_instance.get_sprite(sprite_id:SpriteID::SUPER_SPEED_POWER_UP)
  end

  def collected(player:)
    GameHandler.get_instance.get_scene(scene_id:SceneID::GAME).activate_power_up(player:player, power_up_id:PowerUpID::SUPER_SPEED)
  end

  def draw
    @sprite.draw_rot(@x, @y, ZOrder::ITEM, @angle, 0.5, 0.5, Options::COLLECTIBLE_SCALE, Options::COLLECTIBLE_SCALE)
  end

end