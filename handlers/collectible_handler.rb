require 'gosu'
require_relative '../j_tools'
require_relative '../enums/options'
require_relative '../enums/item_id'
require_relative '../handlers/game_handler'
require_relative '../objects/items/health_bonus'
require_relative '../objects/items/ammo_bonus'
require_relative '../objects/items/fire_power_up'
require_relative '../objects/items/super_speed_power_up'

class CollectibleHandler

  attr_accessor :collectibles

  def initialize(player_1:, player_2:)
    @game_handler = GameHandler.get_instance
    @player1 = player_1
    @player2 = player_2

    @next_spawn = Time.now.to_f + JTools::random_num(2, 3)
    @collectibles = []
  end

  def spawn_collectible(item_id, x:(JTools::random_num(0, Options::GAME_WIDTH - Options::COLLECTIBLE_WIDTH * 2) + Options::COLLECTIBLE_WIDTH), y:(JTools::random_num(0, Options::GAME_HEIGHT - Options::COLLECTIBLE_HEIGHT * 2) + Options::COLLECTIBLE_HEIGHT))
    item = nil
    puts "Spawning #{item_id}"
    if item_id == ItemID::HEALTH
      item = HealthBonus.new(x:x, y:y)
    elsif item_id == ItemID::AMMO
      item = AmmoBonus.new(x:x, y:y)
    elsif item_id == ItemID::FIRE_POWER_UP
      item = FirePowerUp.new(x:x, y:y)
    elsif item_id == ItemID::SUPER_SPEED
      item = SuperSpeedPowerUp.new(x:x, y:y)
    end
    @collectibles << item unless item == nil
  end

  def collectible_radius
    Math.sqrt(Options::COLLECTIBLE_WIDTH / 2 + Options::COLLECTIBLE_HEIGHT / 2)
  end

  def update
    if Time.now.to_f > @next_spawn
      items = [
          ItemID::HEALTH,
          ItemID::AMMO,
          ItemID::FIRE_POWER_UP,
          ItemID::SUPER_SPEED
      ]
      spawn_collectible(items[rand(items.length)])
      @next_spawn = Time.now.to_f + JTools::random_num(5, 7)
    end

    @collectibles.each_with_index do |item, index|
      item.update

      [@player1, @player2].each do |player|
        if Gosu::distance(player.x, player.y, item.x, item.y) < collectible_radius + player.current_hit_radius
          @collectibles.delete_at(index)
          item.collected(player:player)
        end
      end
      @collectibles.delete_at(index) if item.old
    end
  end

  def draw
    @collectibles.each do |item| item.draw end
  end


end