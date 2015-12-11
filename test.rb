class A

  def initialize(kappa)
    @kappa = kappa
  end

  def kappa_times_two
    @kappa * 2
  end

end

class B < A

  def initialize
    @bob = 'hello world'
  end

  def kappa_times_three
    @kappa * 3
  end

  def real_bob
    @bob.upcase
  end

end

puts B.new().kappa_times_three