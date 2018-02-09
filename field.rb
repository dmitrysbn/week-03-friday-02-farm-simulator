class Field

  @@CORN_FOOD_PER_HECTARE = 20
  @@WHEAT_FOOD_PER_HECTARE = 30

  def initialize(type, area)
    @type = type
    @area = area

    if type == "corn"
      @food = @@CORN_FOOD_PER_HECTARE * @area
    else
      @food = @@WHEAT_FOOD_PER_HECTARE * @area
    end
  end

  def type
    @type
  end

  def area
    @area
  end

  def food
    @food
  end

end
