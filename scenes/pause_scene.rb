require_relative './scene'
require_relative '../constants/z_order'
require_relative '../constants/scene_id'

class PauseScene < Scene

  def initialize
    @font = Gosu::Font.new(25)
  end

  def update
    return SceneID::GAME if Gosu::button_down?(Gosu::KbSpace)
    SceneID::MENU if Gosu::button_down?(Gosu::KbQ)
  end

  def draw
    @font.draw('(space) to resume, (q) to quit', 50, 50, ZOrder::GUI)
  end

end