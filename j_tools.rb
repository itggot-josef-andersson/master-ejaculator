class JTools

  def self.clam(numb, min, max)
    numb > min ? (numb < max ? numb : max) : min
  end

  def self.random_num(min, max)
    rand(max - min) + min
  end

end