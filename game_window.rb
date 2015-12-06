require 'gosu'
require_relative './constants/constants'
require_relative './managers/scene_manager'

class GameWindow < Gosu::Window

  def initialize
    super Constants::GAME_WIDTH, Constants::GAME_HEIGHT
    self.caption = 'Master Ejaculator'

    @scene_manager = SceneManager.new
  end

  def update
    ### Update SceneManager
    @scene_manager.update
  end

  def draw
    @scene_manager.draw
  end
end

GameWindow.new.show