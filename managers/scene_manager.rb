require_relative '../constants/scene_id'
require_relative '../scenes/menu_scene'
require_relative '../scenes/goodbye_scene'
require_relative '../scenes/game_scene'
require_relative '../scenes/pause_scene'
require_relative '../scenes/game_over_scene'

class SceneManager

  attr_reader :current_scene, :scenes

  def initialize
    @scenes = [
        MenuScene.new,
        GoodbyeScene.new,
        GameScene.new,
        PauseScene.new,
        GameOverScene.new(self)
    ]

    @current_scene = SceneID::MENU
  end

  def update
    id = @scenes[@current_scene].update
    if id != nil && id >= 0
        puts "Loading scene ##{id}"
        @scenes[@current_scene].leave
        @scenes[id].enter(@current_scene)
        @current_scene = id
    end
  end

  def draw
    @scenes[@current_scene].draw
  end

end