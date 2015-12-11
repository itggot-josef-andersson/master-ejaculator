require_relative '../enums/options'
require_relative '../enums/sprite_id'
require_relative '../enums/z_order'
require_relative '../handlers/game_handler'

class MenuBackground

  def initialize
    @background = GameHandler.get_instance.get_sprite(sprite_id:SpriteID::BACKGROUND)
    @star = GameHandler.get_instance.get_sprite(sprite_id:SpriteID::STAR)
    @stars = []
  end

  def spawn_star
    @stars << Star.new
  end

  def update
    @stars.each_with_index do |star, index|
      if star.dead
        @stars.delete_at(index)
      else
        star.update
      end
    end

    if @stars.length < 64
      spawn_star if JTools::random_num(0, 15) < 1
    end
  end

  def draw
    h, w, c = Options::GAME_HEIGHT, Options::GAME_WIDTH, Gosu::Color::WHITE
    @background.draw_as_quad(
      w, 0, c,
      0, 0, c,
      0, h, c,
      w, h, c,
      ZOrder::BACKGROUND
    )

    @stars.each do |star|
      @star.draw_rot(star.x, star.y, ZOrder::BACKGROUND, 0, 0.5, 0.5, 0.125, 0.125, star.color)
    end
  end

end

class Star

  attr_reader :x, :y

  def initialize
    ### Age goes from 0 to 2600
    @age = 0

    ### argb
    @color = [
        0,
        JTools::random_num(10, 55),
        JTools::random_num(10, 35),
        JTools::random_num(10, 75)
    ]

    @x = JTools::random_num(0, Options::GAME_WIDTH)
    @y = JTools::random_num(0, Options::GAME_HEIGHT)
  end

  def dead
    @age >= 2600
  end

  def update
    @age += JTools::clam(JTools::random_num(11,24), 0, 2600)
    @color[0] = 0.39 * @age - 0.00015 * @age ** 2
  end

  def color
    Gosu::Color.new(@color[0], @color[1], @color[2], @color[3])
  end

end