class GameObject

  attr_reader :type
  attr_accessor :x, :y, :vel_x, :vel_y, :vel_spin, :angle

  def initialize(type:, x:0, y:0, vel_x:0, vel_y:0, vel_spin:0, angle:0)
    @type = type
    @x = x
    @y = y
    @vel_x = vel_x
    @vel_y = vel_y
    @vel_spin = vel_spin
    @angle = angle
  end

  ### Multi-value setters
  def set_pos(x:0, y:0)                          @x, @y                    = x, y                   end
  def set_velocity(vel_x:0, vel_y:0, vel_spin:0) @vel_x, @vel_y, @vel_spin = vel_x, vel_y, vel_spin end

  ### Move and rotate object by velocity
  def move
    @x    += @vel_x
    @y    += @vel_y
    @spin += @vel_spin
  end

  ### Returning true from update will generally remove the object
  def update() end
  def draw() end

end