require_relative '../constants/constants'
require_relative '../constants/item_id'
require_relative '../objects/p_health'
require_relative '../j_tools'

class CollectibleManager

  attr_accessor :collectibles

  def initialize(game_manager)
    @game_manager = game_manager
    @player1 = game_manager.player1
    @player2 = game_manager.player2

    @next_spawn = Time.now.to_f + JTools::random_num(2, 3)
    @collectibles = []
  end

  def spawn_collectible(item_id, x:(JTools::random_num(0, Constants::GAME_WIDTH - Constants::POWER_UP_WIDTH * 2) + Constants::POWER_UP_WIDTH), y:(JTools::random_num(0, Constants::GAME_HEIGHT - Constants::POWER_UP_HEIGHT * 2) + Constants::POWER_UP_HEIGHT))
    item = nil
    if item_id == ItemID::HEALTH_POS
      item = PHealth.new(x:x, y:y)
    end
    @collectibles << item unless item == nil
  end

  def update_collectibles
    if Time.now.to_f > @next_spawn
      spawn_collectible(ItemID::HEALTH_POS)
      @next_spawn = Time.now.to_f + JTools::random_num(5, 15)
    end

    @collectibles.each_with_index do |item, index|
      item.update

      [@player1, @player2].each do |player|
        if Gosu::distance(player.x, player.y, item.x, item.y) < Constants::POWER_UP_RADIUS
          @collectibles.delete_at(index)
          item.collected_by_player(player)
        end
      end
      @collectibles.delete_at(index) if item.should_be_removed
    end
  end

  def draw_collectibles
    @collectibles.each do |item|
      item.draw
    end
  end

end