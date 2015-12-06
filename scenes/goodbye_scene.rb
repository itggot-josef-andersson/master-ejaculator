require 'gosu'
require_relative './scene'
require_relative '../constants/constants'
require_relative '../constants/z_order'

class GoodbyeScene < Scene

  def initialize
    @font = Gosu::Font.new(41)
  end

  def enter(last_scene)
    @close_on = Time.now.to_f + 2
  end

  def update
    exit if @close_on < Time.now.to_f
  end

  def draw
    @font.draw_rel('Thanks for playing!', Constants::GAME_WIDTH / 2, Constants::GAME_HEIGHT / 2, ZOrder::GUI, 0.5, 0.5, 1, 1, Gosu::Color::GREEN)
  end

end