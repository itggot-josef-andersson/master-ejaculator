require_relative '../enums/scene_id'
require_relative '../scenes/menu_scene'
require_relative '../scenes/goodbye_scene'
require_relative '../scenes/game_scene'
require_relative '../scenes/pause_scene'
require_relative '../scenes/game_over_scene'

class SceneHandler

  attr_reader :current_scene, :scenes

  def initialize
    ### Initiate all the scenes!
    add_scene(scene_id:SceneID::MENU, scene:MenuScene.new)
    add_scene(scene_id:SceneID::GAME, scene:GameScene.new)
    add_scene(scene_id:SceneID::PAUSED, scene:PauseScene.new)
    add_scene(scene_id:SceneID::GOODBYE, scene:GoodbyeScene.new)
    add_scene(scene_id:SceneID::GAME_OVER, scene:GameOverScene.new)

    ### "Wouldn't it be hilarious if we started on the goodbye scene though???" - Josef, 2k15
    @current_scene = SceneID::MENU
  end

  ### Add scenes to the list of scenes (not that we ever add a scene after startup)
  def add_scene(scene_id:, scene:)
    @scenes = [] if @scenes == nil
    @scenes[scene_id] = scene
  end

  ### Return the scene instance for specified SceneID
  def scene(scene_id:) @scenes[scene_id] end

  ### Update current scene and check if switching scenes
  def update
    id = @scenes[@current_scene].update
    if id != nil && id >= 0
      puts "Loading scene ##{id}"
      @scenes[@current_scene].leave
      @scenes[id].enter(last_scene:@current_scene)
      @current_scene = id
    end
  end

  ### Draw current scene
  def draw() @scenes[@current_scene].draw end

end