class PowerUp

  attr_accessor :time
  attr_reader :type, :player

  def initialize(time:5 + Time.now.to_f, player:, type:)
    @time   = time
    @player = player
    @type   = type

    ### The power up is enabled when we create the instance, lol.
    enable
  end

  ### Returns true if the power up should be deactivated
  def old() @time < Time.now.to_f end

  ### Called when the power up is activated
  def enable
  end

  ### Called when the power up is deactivated
  def disable
  end

  def update
  end

end