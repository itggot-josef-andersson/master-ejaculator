require_relative './scene'
require_relative '../handlers/game_handler'
require_relative '../enums/z_order'
require_relative '../enums/scene_id'

class PauseScene < Scene

  def initialize
    @font = Gosu::Font.new(25)

    @keyboard_handler = GameHandler.get_instance.keyboard_handler
  end

  def update
    return SceneID::GAME if @keyboard_handler.check_do_fast_press(key:Gosu::KbSpace)
    SceneID::MENU if @keyboard_handler.check_do_fast_press(key:Gosu::KbEscape)
  end

  def draw
    @font.draw('(space) to resume, (esc) to quit', 50, 50, ZOrder::GUI)
  end

end