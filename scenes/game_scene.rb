require 'gosu'
require_relative 'scene'
require_relative '../enums/object_type'
require_relative '../enums/options'
require_relative '../enums/sprite_id'
require_relative '../enums/scene_id'
require_relative '../enums/z_order'
require_relative '../handlers/game_handler'
require_relative '../handlers/projectile_handler'
require_relative '../handlers/collectible_handler'
require_relative '../handlers/power_up_handler'
require_relative '../objects/player'

class GameScene < Scene

  def initialize
    @background = GameHandler.get_instance.get_sprite(sprite_id:SpriteID::SPACE_BACKGROUND)
    @font       = Gosu::Font.new(22)

    @player1 = Player.new(type:ObjectType::PLAYER1)
    @player2 = Player.new(type:ObjectType::PLAYER2)

    @keyboard_handler = GameHandler.get_instance.keyboard_handler

    ### These things ... silly af
    @projectile_handler  = ProjectileHandler.new(player_1:@player1, player_2:@player2)
    @collectible_handler = CollectibleHandler.new(player_1:@player1, player_2:@player2)
    @power_up_handler    = PowerUpHandler.new
  end

  def reset
    @player1.ammo                         = @player2.ammo                         = Options::PLAYER_START_AMMO
    @player1.health                       = @player2.health                       = Options::PLAYER_START_HEALTH
    @player1.accelerating                 = @player2.accelerating                 = false
    @player1.move_acceleration_multiplier = @player2.move_acceleration_multiplier = 1
    @player1.spin_acceleration_multiplier = @player2.spin_acceleration_multiplier = 1
    @player1.scale_multiplier             = @player2.scale_multiplier             = 1
    @player1.next_shot                    = @player2.next_shot                    = 0
    @player1.set_pos(x:Options::PLAYER1_START_POSITION[0], y:Options::PLAYER1_START_POSITION[1])
    @player2.set_pos(x:Options::PLAYER2_START_POSITION[0], y:Options::PLAYER2_START_POSITION[1])
    @player1.angle = Options::PLAYER1_START_POSITION[2]
    @player2.angle = Options::PLAYER2_START_POSITION[2]
    @player1.set_velocity
    @player2.set_velocity

    @projectile_handler.projectiles = []
    @collectible_handler.collectibles = []
    @power_up_handler.active_power_ups = []
  end

  ### Returns the ObjectType of the winner (-1=no winner)
  def winner
    if @player1.dead || @player2.dead
      return @player1.dead ? ObjectType::PLAYER2 : ObjectType::PLAYER1
    end
    -1
  end

  ### Activates a power up for player
  def activate_power_up(player:, power_up_id:) @power_up_handler.activate_power_up(player:player, power_up_id:power_up_id) end

  def enter(last_scene:)
    ### Reset the scene if last_scene wasn't PauseScene
    reset unless last_scene == SceneID::PAUSED

    ### Start listening to key inputs
    @keyboard_handler.listen_to(key:[Gosu::KbR, Gosu::KbN, Gosu::KbW, Gosu::KbA, Gosu::KbS, Gosu::KbD, Gosu::KbUp, Gosu::KbDown, Gosu::KbLeft, Gosu::KbRight, Gosu::KbT, Gosu::KbM])
  end

  ### Stop listening to key inputs upon leaving scene
  def leave() @keyboard_handler.listen_to(key:[Gosu::KbR, Gosu::KbN, Gosu::KbW, Gosu::KbA, Gosu::KbS, Gosu::KbD, Gosu::KbUp, Gosu::KbDown, Gosu::KbLeft, Gosu::KbRight, Gosu::KbT, Gosu::KbM], remove:true) end

  def update
    ### Pause if escape was pressed
    return SceneID::PAUSED if @keyboard_handler.check_do_fast_press(key:Gosu::KbEscape)

    ### Check for input for player 1
    @player1.accelerating = false
    @player1.left     if @keyboard_handler.is_down(key:Gosu::KbLeft)
    @player1.right    if @keyboard_handler.is_down(key:Gosu::KbRight)
    @player1.forward  if @keyboard_handler.is_down(key:Gosu::KbUp)
    @player1.backward if @keyboard_handler.is_down(key:Gosu::KbDown)
    @projectile_handler.spawn_projectile(type:ObjectType::JIZZ,      sender:@player1) if @keyboard_handler.is_down(key:Gosu::KbM)
    @projectile_handler.spawn_projectile(type:ObjectType::HUGE_JIZZ, sender:@player1) if @keyboard_handler.is_down(key:Gosu::KbN)

    ### Check for input for player 2
    @player2.accelerating = false
    @player2.left     if @keyboard_handler.is_down(key:Gosu::KbA)
    @player2.right    if @keyboard_handler.is_down(key:Gosu::KbD)
    @player2.forward  if @keyboard_handler.is_down(key:Gosu::KbW)
    @player2.backward if @keyboard_handler.is_down(key:Gosu::KbS)
    @projectile_handler.spawn_projectile(type:ObjectType::JIZZ,      sender:@player2) if @keyboard_handler.is_down(key:Gosu::KbT)
    @projectile_handler.spawn_projectile(type:ObjectType::HUGE_JIZZ, sender:@player2) if @keyboard_handler.is_down(key:Gosu::KbR)

    ### Update players
    @player1.update
    @player2.update

    @projectile_handler.update
    @collectible_handler.update
    @power_up_handler.update

    ### Give both players some ammo
    @player1.give_ammo(ammo:Options::PLAYER_AMMO_PER_TICK)
    @player2.give_ammo(ammo:Options::PLAYER_AMMO_PER_TICK)

    ### Go to GameOverScene if either player is DEAD
    SceneID::GAME_OVER if @player1.dead || @player2.dead
  end

  def draw
    h, w, c = Options::GAME_HEIGHT, Options::GAME_WIDTH, Gosu::Color.new(0xdd_aaaacc)
    @background.draw_as_quad(
        w, 0, c,
        0, 0, c,
        0, h, c,
        w, h, c,
        ZOrder::BACKGROUND
    )

    ### Draw the players
    @player1.draw
    @player2.draw

    @projectile_handler.draw
    @collectible_handler.draw

    ### Draw the overlay
    w, o = Options::GAME_WIDTH, ZOrder::GUI
    @font.draw_rel('[Player 1]', 10, 10, o, 0, 0, 1, 1, Gosu::Color::AQUA)
    @font.draw_rel("#{@player1.ammo.to_i}% turned on", 10, 35, o, 0, 0, 1, 1, Gosu::Color::GRAY)
    @font.draw_rel("#{@player1.health} health", 10, 60, o, 0, 0, 1, 1, Gosu::Color::GREEN)

    @font.draw_rel('[Player 2]', w - 10, 10, o, 1, 0, 1, 1, Gosu::Color::AQUA)
    @font.draw_rel("#{@player2.ammo.to_i}% turned on", w - 10, 35, o, 1, 0, 1, 1, Gosu::Color::GRAY)
    @font.draw_rel("#{@player2.health} health", w - 10, 60, o, 1, 0, 1, 1, Gosu::Color::GREEN)
  end

end