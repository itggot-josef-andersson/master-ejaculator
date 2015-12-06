require 'gosu'
require_relative './scene'
require_relative '../constants/scene_id'
require_relative '../constants/constants'
require_relative '../constants/z_order'

class MenuScene < Scene

  def initialize
    @images = Gosu::Image::load_tiles('./resources/menu_sheet.png', 128, 64)
  end

  def update
    return SceneID::GAME if Gosu::button_down?(Gosu::KbSpace)
    SceneID::GOODBYE if Gosu::button_down?(Gosu::KbEscape)
  end

  def draw
    y_dif = Constants::GAME_HEIGHT / (@images.length + 1)
    x = Constants::GAME_WIDTH / 2

    @images.each_with_index do |image, index|
      image.draw(x - image.width / 2, y_dif * (index + 1) - image.height / 2, ZOrder::GUI)
    end
  end

end