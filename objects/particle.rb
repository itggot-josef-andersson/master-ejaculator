class Particle

  def initialize(type:, x:0, y:0, animation_frames:nil)
    @type = type
    @x = x
    @y = y
    @animation_frames = animation_frames
    @time = Time.now.to_f
    @index = 0
  end

  def animation_index
    if @time + 0.2 > Time.now.to_f
      @index += 1
      @time = Time.now.to_f
    end
    @index
  end

  ### Returning true will remove the particle
  def update
  end

  def draw
  end

end