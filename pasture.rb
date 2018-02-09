class Pasture

  @@COWS_BIRTH_RATE = 1.5
  @@CHICKEN_BIRTH_RATE = 3

  def initialize(type, number_of_animals)
    @type = type
    @number_of_animals = number_of_animals

    if type == "cows"
      @birth_rate = @@COWS_BIRTH_RATE
    else
      @birth_rate = @@CHICKEN_BIRTH_RATE
    end
  end

  def type
    @type
  end

  def number_of_animals
    @number_of_animals
  end

  def birth_rate
    @birth_rate
  end

  def produce_offspring
    @number_of_animals = (@number_of_animals * @birth_rate).round
  end

end
