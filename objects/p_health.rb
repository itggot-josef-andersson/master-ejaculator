require_relative './game_object'
require_relative '../constants/z_order'
require_relative '../constants/constants'
require_relative '../constants/object_type'

class PHealth < GameObject

  def initialize(x:0, y:0, remove_at_time:(Time.now.to_f + 20))
    super(type:ObjectType::PHEALTH, x:x, y:y)
    @remove_at_time = remove_at_time
    @sprite = Gosu::Image.new('./resources/pow_health_p.png')
  end

  def should_be_removed
    ### Remove the object after some time has passed
    Time.now.to_f > @remove_at_time
  end

  def collected_by_player(player)
    player.health += Constants::POW_HEALTH
  end

  def draw
    @sprite.draw(@x - @sprite.width / 2, @y - @sprite.height / 2, ZOrder::ITEM)
  end

end