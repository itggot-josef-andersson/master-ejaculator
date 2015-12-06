class Scene

  attr_accessor :enabled

  def initialize
  end

  ### Called when scenes is loaded for the first time
  def enter(last_scene)
  end

  ### Called when current scenes is being closed and another one opened
  def leave
  end

  ### Update method for scenes
  ### Returns ScreenID if wanting to switch scenes
  def update
  end

  ### Draw method for scenes
  def draw
  end

end