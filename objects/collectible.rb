class Collectible < GameObject

  def initialize(type:, x:0, y:0, vel_x:0, vel_y:0, vel_spin:0, angle:0, destroy_time:-1)
    super(type:type, x:x, y:y, vel_x:vel_x, vel_y:vel_y, angle:angle, vel_spin:vel_spin)

    ### The time of which this GameObject will be demolished (-1=never)
    @destroy_time = destroy_time
  end

  ### An object is old if the destroy_time has passed
  def old() if @destroy_time != -1 then Time.now.to_f > @destroy_time else false end end

  ### What should happen when item is collected by a player
  def collected(player:)
  end

end