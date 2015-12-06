class Constants

  GAME_WIDTH =  640 #1024
  GAME_HEIGHT = 480 #768

  START_HEALTH = 100
  START_AMMO = 50

  SHOOTING_COST = 8
  SHOOTING_DELAY = 0.2

  JIZZ_SPEED = 20
  JIZZ_DAMAGE = 10

  POW_HEALTH = 25

  POWER_UP_WIDTH = 32
  POWER_UP_HEIGHT = POWER_UP_WIDTH

  POWER_UP_RADIUS = 32

  HIT_RADIUS = Math::sqrt(((32 / 2) ** 2) * 2).ceil

end