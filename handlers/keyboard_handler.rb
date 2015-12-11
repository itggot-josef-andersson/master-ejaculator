require 'gosu'

class KeyboardHandler

  def initialize
    @listen_keys = []
    @current_keys_down = []
    @keys_previously_down = []
    @keys_waiting_for_release = []
  end

  ### Either adds a specific key or removes a key to listen to
  def listen_to(key:, remove:false)
    key = [key] unless key.class == Array
    key.each do |k|
      if @listen_keys.include?(k)
        if remove
          @listen_keys.delete(k)
          @current_keys_down.delete(k)
          @keys_previously_down.delete(k)
        end
      else
        @listen_keys << k
      end
    end
  end

  def wait_for_release(key:, remove:false)
    if @keys_waiting_for_release.include?(key)
      if remove
        @keys_waiting_for_release.delete(key)
      end
    else
      @keys_waiting_for_release << key
    end
  end

  def check_do_fast_press(key:)
    if is_down(key:key)
      wait_for_release(key:key)
      return true
    end
    false
  end

  def was_pressed(key:)
    @keys_previously_down.include?(key)
  end

  def is_down(key:)
    @current_keys_down.include?(key) && !@keys_waiting_for_release.include?(key)
  end

  def update
    @keys_previously_down.clear
    @listen_keys.each do |key|
      if Gosu::button_down?(key)
        @current_keys_down << key unless @current_keys_down.include?(key) && @keys_waiting_for_release.include?(key)
        @keys_previously_down.delete(key)
      else
        if @current_keys_down.include?(key)
          @current_keys_down.delete(key)
          @keys_waiting_for_release.delete(key)
          @keys_previously_down << key
        end
      end
    end
  end

end