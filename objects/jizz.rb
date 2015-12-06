require 'gosu'
require_relative './game_object'
require_relative '../constants/object_type'
require_relative '../constants/constants'
require_relative '../constants/z_order'

class Jizz < GameObject

  attr_reader :player, :width, :height

  def initialize(shooter, type:(ObjectType::JIZZ), speed:(Constants::JIZZ_SPEED))
    super(type:type, vel_x:(Gosu::offset_x(shooter.angle, speed)), vel_y:(Gosu::offset_y(shooter.angle, speed)), x:shooter.x, y:shooter.y, angle:shooter.angle)

    @width = 16
    @height = 32
    @player = shooter
    @sprite = Gosu::Image.new('./resources/jizz.png')
  end

  def update
    @x += @vel_x
    @y += @vel_y
  end

  def draw
    @sprite.draw_rot(@x, @y, ZOrder::PROJECTILE, @angle)
  end

end