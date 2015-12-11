class Scene

  def initialize
  end

  ### Called when scenes is loaded for the first time
  ### last_scene is the ID of the previous scene
  def enter(last_scene:)
  end

  ### Called when current scenes is being closed and another one opened
  def leave
  end

  ### Update method for scenes
  ### Return a ScreenID if wanting to switch scenes
  def update
  end

  ### Draw method for scenes
  def draw
  end

end