class Field

  @@CORN_FOOD = 20
  @@WHEAT_FOOD = 30

  def initialize(type, area)
    @type = type
    @area = area
  end

  def type
    @type
  end

  def area
    @area
  end

end
