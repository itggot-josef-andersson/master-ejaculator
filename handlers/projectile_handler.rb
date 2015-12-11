require 'gosu'
require_relative '../objects/projectiles/jizz'
require_relative '../enums/object_type'
require_relative '../enums/options'

class ProjectileHandler

  attr_accessor :projectiles

  def initialize(player_1:, player_2:)
    @projectiles = []

    @player_1 = player_1
    @player_2 = player_2

    @normal_jizz_speed_multiplier = 1
    @huge_jizz_speed_multiplier   = 1
  end

  ### Used to spawn pojectiles
  def spawn_projectile(type:, sender:)
    if type == ObjectType::JIZZ
      if sender.ammo - Options::NORMAL_JIZZ_PRICE >= 0
        if sender.next_shot < Time.now.to_f
          sender.ammo -= Options::NORMAL_JIZZ_PRICE
          sender.next_shot = Time.now.to_f + Options::SHOOTING_DELAY
          vel_x = (Gosu::offset_x(sender.angle, normal_jizz_speed))
          vel_y = (Gosu::offset_y(sender.angle, normal_jizz_speed))
          @projectiles << Jizz.new(sender:sender, type:type, x:sender.x, y:sender.y, vel_x:vel_x, vel_y:vel_y, angle:sender.angle)
        end
      end
    elsif type == ObjectType::HUGE_JIZZ
      if sender.ammo - Options::HUGE_JIZZ_PRICE >= 0
        if sender.next_shot < Time.now.to_f
          sender.ammo -= Options::HUGE_JIZZ_PRICE
          sender.next_shot = Time.now.to_f + Options::SHOOTING_DELAY
          vel_x = (Gosu::offset_x(sender.angle, normal_jizz_speed))
          vel_y = (Gosu::offset_y(sender.angle, normal_jizz_speed))
          @projectiles << Jizz.new(sender:sender, type:type, x:sender.x, y:sender.y, vel_x:vel_x, vel_y:vel_y, angle:sender.angle, scale:Options::HUGE_JIZZ_SCALE)
        end
      end
    end
  end

  ### After multipliers are applied
  def normal_jizz_speed() Options::NORMAL_JIZZ_SPEED * @normal_jizz_speed_multiplier end
  def huge_jizz_speed()   Options::HUGE_JIZZ_SPEED * @huge_jizz_speed_multiplier end

  def update
    @projectiles.each_with_index do |projectile, index|
      ### If a projectile's update method returns true we will delete the object
      if projectile.update
        @projectiles.delete_at(index)
      else
        if projectile.type == ObjectType::JIZZ
          player = (projectile.sender.type == ObjectType::PLAYER1 ? @player_2 : @player_1)
          if Gosu::distance(projectile.x, projectile.y, player.x, player.y) < player.current_hit_radius + projectile.hit_radius / 2
            player.hit(damage:Options::NORMAL_JIZZ_DAMAGE)
            @projectiles.delete_at(index)
          end
        elsif projectile.type == ObjectType::HUGE_JIZZ
          player = (projectile.sender.type == ObjectType::PLAYER1 ? @player_2 : @player_1)
          if Gosu::distance(projectile.x, projectile.y, player.x, player.y) < player.current_hit_radius + projectile.hit_radius / 2
            player.hit(damage:Options::HUGE_JIZZ_DAMAGE)
            @projectiles.delete_at(index)
          end
        end
      end
    end
  end

  ### Draw projectiles
  def draw() @projectiles.each do |projectile| projectile.draw end end

end