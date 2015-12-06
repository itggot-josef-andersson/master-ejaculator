require 'gosu'
require_relative './scene'
require_relative '../constants/scene_id'
require_relative '../constants/object_type'
require_relative '../managers/game_manager'

class GameScene < Scene

  attr_reader :game_manager

  def initialize
    @background = Gosu::Image.new('./resources/space.png')
    @font = Gosu::Font.new(22)

    @game_manager = GameManager.new
  end

  def enter(last_scene)
    @game_manager.setup unless last_scene == SceneID::PAUSED
  end

  def update
    return SceneID::PAUSED if Gosu::button_down?(Gosu::KbEscape)
    @game_manager.update
  end

  def draw
    h, w, c = Constants::GAME_HEIGHT, Constants::GAME_WIDTH, Gosu::Color::WHITE
    @background.draw_as_quad(
        0, h, c,
        w, h, c,
        w, 0, c,
        0, 0, c,
        ZOrder::BACKGROUND
    )

    @game_manager.draw

    w, o = Constants::GAME_WIDTH, ZOrder::GUI
    @font.draw_rel('[Player 1]', 10, 10, o, 0, 0, 1, 1, Gosu::Color::AQUA)
    @font.draw_rel("#{@game_manager.player1.ammo.to_i}% turned on", 10, 35, o, 0, 0, 1, 1, Gosu::Color::GRAY)
    @font.draw_rel("#{@game_manager.player1.health} health", 10, 60, o, 0, 0, 1, 1, Gosu::Color::GREEN)

    @font.draw_rel('[Player 2]', w - 10, 10, o, 1, 0, 1, 1, Gosu::Color::AQUA)
    @font.draw_rel("#{@game_manager.player2.ammo.to_i}% turned on", w - 10, 35, o, 1, 0, 1, 1, Gosu::Color::GRAY)
    @font.draw_rel("#{@game_manager.player2.health} health", w - 10, 60, o, 1, 0, 1, 1, Gosu::Color::GREEN)
  end

end