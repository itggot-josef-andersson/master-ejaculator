require_relative '../collectible'
require_relative '../../enums/options'
require_relative '../../enums/object_type'

class AmmoBonus < Collectible

  def initialize(x:0, y:0, destroy_time:(Time.now.to_f + Options::COLLECTIBLE_DESTROY_TIMER))
    super(type:ObjectType::AMMO_BONUS, x:x, y:y, destroy_time:destroy_time)

    @sprite = GameHandler.get_instance.get_sprite(sprite_id:SpriteID::AMMO_BONUS)
  end

  def collected(player:)
    player.give_ammo(ammo:Options::AMMO_BONUS_AMOUNT)
  end

  def draw
    @sprite.draw_rot(@x, @y, ZOrder::ITEM, @angle, 0.5, 0.5, Options::COLLECTIBLE_SCALE, Options::COLLECTIBLE_SCALE)
  end

end