require 'gosu'
require_relative 'keyboard_handler'
require_relative 'scene_handler'
require_relative 'sprite_handler'

class GameHandler

  attr_reader :keyboard_handler, :scene_handler, :sprite_handler

  def initialize
    ### Here's the class variable people hate
    @@game_handler_instance = self

    @keyboard_handler = KeyboardHandler.new
    @sprite_handler   = SpriteHandler.new
    @scene_handler    = SceneHandler.new

    ### Escape will be our go-to pause/exit button
    @keyboard_handler.listen_to(key:Gosu::KbEscape)
    @keyboard_handler.listen_to(key:Gosu::KbSpace)
  end

  ### Returns a sprite from the SpriteHandler
  def get_sprite(sprite_id:) @sprite_handler.sprite(sprite_id:sprite_id) end

  ### Returns a scene from the SceneHandler
  def get_scene(scene_id:) @scene_handler.scene(scene_id:scene_id) end

  ### Update everything
  def update
    @keyboard_handler.update
    @scene_handler.update
  end

  ### Draw everything
  def draw
    @scene_handler.draw
  end

  ### Since the class variables worked so well on test #1 I'll be using it in this class too.
  ### Note: This will ensure that creating multiple game_handler instances f*cks up the game, good.
  def self.get_instance() @@game_handler_instance end

end