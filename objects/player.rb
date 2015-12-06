require 'gosu'
require_relative './game_object'
require_relative '../constants/z_order'
require_relative '../constants/constants'
require_relative '../j_tools'

class Player < GameObject

  SPIN_ACCELERATION = 0.85
  SPIN_DECELERATION = 0.8
  MOVE_ACCELERATION = 0.375
  MOVE_DECELERATION = 0.95
  WIDTH = 32
  HEIGHT = 32

  attr_accessor :ammo, :next_shot, :accelerating, :health, :sprite

  def initialize(type)
    super(type:type)
    @next_shot = 0
    @health
    @ammo
    @accelerating = false

    @animation_frames = Gosu::Image::load_tiles('./resources/thrust.png', 16, 16)

    if type == ObjectType::PLAYER1
      @sprite = Gosu::Image.new('./resources/player1.png')
    elsif type == ObjectType::PLAYER2
      @sprite = Gosu::Image.new('./resources/player2.png')
    else
      @sprite = Gosu::Image.new('./resources/error.png')
    end
  end

  def left
    @vel_spin -= SPIN_ACCELERATION
  end

  def right
    @vel_spin += SPIN_ACCELERATION
  end

  def forward
    @vel_x += Gosu::offset_x(@angle, MOVE_ACCELERATION)
    @vel_y += Gosu::offset_y(@angle, MOVE_ACCELERATION)
    @accelerating = true
  end

  def backward
    @vel_x -= Gosu::offset_x(@angle, MOVE_ACCELERATION / 2.5)
    @vel_y -= Gosu::offset_y(@angle, MOVE_ACCELERATION / 2.5)
  end

  def hit(damage)
    @health -= damage
    puts "Player #{@type + 1} lost #{damage} health"
    if @health <= 0
      puts "Player #{type + 1} died"
    end
  end

  def dead
    @health <= 0
  end

  def update
    @x += @vel_x
    @y += @vel_y
    @angle += @vel_spin

    @x %= Constants::GAME_WIDTH
    @y %= Constants::GAME_HEIGHT

    @vel_spin *= SPIN_DECELERATION
    @vel_x *= MOVE_DECELERATION
    @vel_y *= MOVE_DECELERATION

    @ammo += 0.2
    @ammo = JTools::clam(@ammo, 0, 100)
  end

  def draw
    @animation_frame = @animation_frames[Gosu::milliseconds / 100 % @animation_frames.size]

    @sprite.draw_rot(@x, @y, ZOrder::PLAYER, @angle - 45)
    @animation_frame.draw_rot(@x, @y, ZOrder::PARTICLE, @angle, 0.5, -0.5) if @accelerating

    if @x < 23
      @sprite.draw_rot(@x + Constants::GAME_WIDTH, @y, ZOrder::PLAYER, @angle - 45)
      @animation_frame.draw_rot(@x + Constants::GAME_WIDTH, @y, ZOrder::PARTICLE, @angle, 0.5, -0.5) if @accelerating
    end
    if @x > Constants::GAME_WIDTH - 23
      @sprite.draw_rot(@x - Constants::GAME_WIDTH, @y, ZOrder::PLAYER, @angle - 45)
      @animation_frame.draw_rot(@x - Constants::GAME_WIDTH, @y, ZOrder::PARTICLE, @angle, 0.5, -0.5) if @accelerating
    end
    if @y < 23
      @sprite.draw_rot(@x, @y + Constants::GAME_HEIGHT, ZOrder::PLAYER, @angle - 45)
      @animation_frame.draw_rot(@x, @y + Constants::GAME_HEIGHT, ZOrder::PARTICLE, @angle, 0.5, -0.5) if @accelerating
    end
    if @y > Constants::GAME_HEIGHT - 23
      @sprite.draw_rot(@x, @y - Constants::GAME_HEIGHT, ZOrder::PLAYER, @angle - 45)
      @animation_frame.draw_rot(@x, @y - Constants::GAME_HEIGHT, ZOrder::PARTICLE, @angle, 0.5, -0.5) if @accelerating
    end
  end

end