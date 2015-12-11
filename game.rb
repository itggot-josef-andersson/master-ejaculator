require 'gosu'
require_relative 'enums/options'
require_relative 'handlers/game_handler'

class Game < Gosu::Window

  attr_reader :game_handler

  def initialize
    super Options::GAME_WIDTH, Options::GAME_HEIGHT
    self.caption = "#{Options::GAME_TITLE} - v#{Options::GAME_VERSION}"

    ### Doing this makes this game instance accessible from all classes using Game.get_instance
    @@game_instance = self

    @game_handler = GameHandler.new
  end

  ### Update game
  def update() @game_handler.update end

  ### Draw game
  def draw() @game_handler.draw end

  ### Class variables are "not recommended" to use. I think that they are genius.
  def self.get_instance() @@game_instance end
end