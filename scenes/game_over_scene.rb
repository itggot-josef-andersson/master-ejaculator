require_relative './scene'
require_relative '../enums/scene_id'
require_relative '../enums/object_type'

class GameOverScene < Scene

  def initialize
    @keyboard_handler = GameHandler.get_instance.keyboard_handler

    @font = Gosu::Font.new(25)
    @text = ''
  end

  def enter(last_scene:)
    winner_type = GameHandler.get_instance.get_scene(scene_id:SceneID::GAME).winner
    if winner_type == ObjectType::PLAYER1
      @text = 'Player 1 won!'
    elsif winner_type == ObjectType::PLAYER2
      @text = 'Player 2 won!'
    else
      @text = 'Something went downhill...'
    end
  end

  def update
    return SceneID::GAME if @keyboard_handler.check_do_fast_press(key:Gosu::KbSpace)
    SceneID::MENU if @keyboard_handler.check_do_fast_press(key:Gosu::KbEscape)
  end

  def draw
    @font.draw(@text, 50, 50, ZOrder::GUI, 1, 1, Gosu::Color::RED)
    @font.draw('(esc) to go to the main menu, (space) to play again', 50, 100, ZOrder::GUI)
  end

end