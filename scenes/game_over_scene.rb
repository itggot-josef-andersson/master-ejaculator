require_relative './scene'
require_relative '../constants/scene_id'

class GameOverScene < Scene

  def initialize(scene_manager)
    @scene_manager = scene_manager
    @winner
    @font = Gosu::Font.new(25)
  end

  def enter(last_scene)
    ### This method for choosing the winner is pretty bad...
    ### -will brake if typeID of p1 != 0 and p2 != 1
    @winner = @scene_manager.scenes[SceneID::GAME].game_manager.winner + 1
  end

  def update
    return SceneID::GAME if Gosu::button_down?(Gosu::KbR)
    SceneID::MENU if Gosu::button_down?(Gosu::KbB)
  end

  def draw
    @font.draw("Player #{@winner} won!", 50, 50, ZOrder::GUI, 1, 1, Gosu::Color::RED)
    @font.draw('(b) to go to the main menu, (r) to play again', 50, 100, ZOrder::GUI)
  end

end