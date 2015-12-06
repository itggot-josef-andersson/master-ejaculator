require 'gosu'
require_relative './projectile_manager'
require_relative './collectible_manager'
require_relative '../constants/object_type'
require_relative '../constants/constants'
require_relative '../objects/player'

class GameManager

  attr_reader :player1, :player2

  def initialize
    @player1 = Player.new(ObjectType::PLAYER1)
    @player2 = Player.new(ObjectType::PLAYER2)

    @projectile_manager = ProjectileManager.new(self)
    @collectible_manager = CollectibleManager.new(self)
  end

  def setup
    @player1.health = Constants::START_HEALTH
    @player1.ammo = Constants::START_AMMO
    @player1.next_shot = @player1.vel_spin = @player1.vel_x = @player1.vel_y = 0
    @player1.angle = -45
    @player1.set_pos(x:150, y:150)

    @player2.health = Constants::START_HEALTH
    @player2.ammo = Constants::START_AMMO
    @player2.next_shot = @player2.vel_spin = @player2.vel_x = @player2.vel_y = 0
    @player2.angle = 135
    @player2.set_pos(x:Constants::GAME_WIDTH - 150, y:Constants::GAME_HEIGHT - 150)

    @projectile_manager.projectiles = []
    @collectible_manager.collectibles = []
  end

  def update
    @player1.accelerating = false
    @player1.left if Gosu::button_down?(Gosu::KbLeft)
    @player1.right if Gosu::button_down?(Gosu::KbRight)
    @player1.forward if Gosu::button_down?(Gosu::KbUp)
    @player1.backward if Gosu::button_down?(Gosu::KbDown)
    @projectile_manager.player_shoot_jizz(@player1) if Gosu::button_down?(Gosu::KbM)

    @player2.accelerating = false
    @player2.left if Gosu::button_down?(Gosu::KbA)
    @player2.right if Gosu::button_down?(Gosu::KbD)
    @player2.forward if Gosu::button_down?(Gosu::KbW)
    @player2.backward if Gosu::button_down?(Gosu::KbS)
    @projectile_manager.player_shoot_jizz(@player2) if Gosu::button_down?(Gosu::KbT)

    @player1.update
    @player2.update

    @projectile_manager.update_projectiles
    @collectible_manager.update_collectibles

    SceneID::GAME_OVER if @player1.dead || @player2.dead
  end

  def winner
    winner = nil
    if @player1.dead && @player2.dead
    elsif @player1.dead
      winner = ObjectType::PLAYER2
    elsif @player2.dead
      winner = ObjectType::PLAYER1
    end
    winner
  end

  def draw
    @player1.draw
    @player2.draw

    @projectile_manager.draw_projectiles
    @collectible_manager.draw_collectibles
  end

end