require 'gosu'
require_relative '../objects/jizz'
require_relative '../constants/object_type'
require_relative '../constants/constants'

class ProjectileManager

  attr_accessor :projectiles

  def initialize(game_manager)
    @projectiles = []
    @p1 = game_manager.player1
    @p2 = game_manager.player2
  end

  def length
    @projectiles.length
  end

  def player_shoot_jizz(player, type:(ObjectType::JIZZ))
    if player.ammo - Constants::SHOOTING_COST >= 0
      if player.next_shot < Time.now.to_f
        player.ammo -= Constants::SHOOTING_COST
        player.next_shot = Time.now.to_f + Constants::SHOOTING_DELAY
        @projectiles << Jizz.new(player, type:type)
      end
    end
  end

  def update_projectiles
    @projectiles.each_index do |index|
      p = @projectiles[index]
      if p.x < 0 - p.width / 2 || p.x > Constants::GAME_WIDTH + p.width / 2 || p.y < 0 - p.height / 2 || p.y > Constants::GAME_HEIGHT + p.height / 2
        @projectiles.delete_at(index)
      else
        p.update
        if p.player.type == ObjectType::PLAYER1
          if Gosu::distance(p.x, p.y, @p2.x, @p2.y) < Constants::HIT_RADIUS
            @p2.hit(Constants::JIZZ_DAMAGE)
            @projectiles.delete_at(index)
          end
        elsif p.player.type == ObjectType::PLAYER2
          if Gosu::distance(p.x, p.y, @p1.x, @p1.y) < Constants::HIT_RADIUS
            @p1.hit(Constants::JIZZ_DAMAGE)
            @projectiles.delete_at(index)
          end
        end
      end
    end
  end

  def draw_projectiles
    @projectiles.each do |projectile|
      projectile.draw
    end
  end

end