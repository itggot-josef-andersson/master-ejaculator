require 'gosu'
require_relative 'scene'
require_relative '../handlers/game_handler'
require_relative '../enums/options'
require_relative '../enums/scene_id'
require_relative '../enums/sprite_id'
require_relative '../enums/z_order'
require_relative '../animations/menu_background'

class MenuScene < Scene

  def initialize
    @images = GameHandler.get_instance.get_sprite(sprite_id:SpriteID::MENU_SHEET)

    @background = MenuBackground.new

    @keyboard_handler = GameHandler.get_instance.keyboard_handler
  end

  def update
    @background.update

    ### Check for key presses
    return SceneID::GAME if @keyboard_handler.check_do_fast_press(key:Gosu::KbSpace)
    SceneID::GOODBYE if @keyboard_handler.check_do_fast_press(key:Gosu::KbEscape)
  end

  def draw
    @background.draw

    y_dif = Options::GAME_HEIGHT / (@images.length + 2)
    x = Options::GAME_WIDTH / 2
    @images.each_with_index do |image, index|
      image.draw(x - image.width / 2, y_dif * (index + 1) - image.height / 2, ZOrder::GUI)
    end
  end

end