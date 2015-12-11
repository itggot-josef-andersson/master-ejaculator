require 'gosu'
require_relative '../enums/sprite'
require_relative '../enums/sprite_id'

class SpriteHandler

  def initialize
    @sprites = []

    load_sprite(sprite_id:SpriteID::MENU_SHEET,           data:Gosu::Image::load_tiles(Sprite::MENU_SHEET, 128, 64))
    load_sprite(sprite_id:SpriteID::PLAYER1,              data:Gosu::Image.new(Sprite::PLAYER1))
    load_sprite(sprite_id:SpriteID::PLAYER2,              data:Gosu::Image.new(Sprite::PLAYER2))
    load_sprite(sprite_id:SpriteID::THRUST,               data:Gosu::Image::load_tiles(Sprite::THRUST, 128, 128))
    load_sprite(sprite_id:SpriteID::SPACE_BACKGROUND,     data:Gosu::Image.new(Sprite::SPACE_BACKGROUND))
    load_sprite(sprite_id:SpriteID::BACKGROUND,           data:Gosu::Image.new(Sprite::BACKGROUND))
    load_sprite(sprite_id:SpriteID::STAR,                 data:Gosu::Image.new(Sprite::STAR))
    load_sprite(sprite_id:SpriteID::NORMAL_JIZZ,          data:Gosu::Image::load_tiles(Sprite::NORMAL_JIZZ, 256, 512))
    load_sprite(sprite_id:SpriteID::SMOKE_EFFECT,         data:Gosu::Image::load_tiles(Sprite::SMOKE_EFFECT, 32, 32))
    load_sprite(sprite_id:SpriteID::HEALTH_BONUS,         data:Gosu::Image.new(Sprite::HEALTH_BONUS))
    load_sprite(sprite_id:SpriteID::AMMO_BONUS,           data:Gosu::Image.new(Sprite::AMMO_BONUS))
    load_sprite(sprite_id:SpriteID::FIRE_POWER_UP,        data:Gosu::Image.new(Sprite::FIRE_POWER_UP))
    load_sprite(sprite_id:SpriteID::SUPER_SPEED_POWER_UP, data:Gosu::Image.new(Sprite::SUPER_SPEED_POWER_UP))
  end

  ### Add a sprite to the array of sprites (though technically not "loading" the sprites here...)
  def load_sprite(sprite_id:, data:)
    @sprites[sprite_id] = data
  end

  ### Returns a sprite (or array of sprites...)
  def sprite(sprite_id:) @sprites[sprite_id] end

end