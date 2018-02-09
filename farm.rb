require './field.rb'
require 'ap'
require 'pp'

class Farm

  def initialize
    @fields = []
    @total_food_ever = 0
  end

  def fields
    @fields
  end

  def total_food_ever
    @total_food_ever
  end

  def main_menu
    while true
      print_main_menu
      user_selected = gets.chomp.downcase
      call_option(user_selected)
      sleep(0.5)
    end
  end

  def print_main_menu
    puts '*************************************'
    puts 'Options:'
    puts 'field -> adds a new field'
    puts 'harvest -> harvests crops and adds to total harvested'
    puts 'status -> displays some information about the farm'
    puts 'relax -> provides lovely descriptions of your fields'
    puts 'exit -> exits the program'
  end

  def call_option(user_selected)
    case user_selected
    when 'field' then add_new_field
    when 'harvest' then collect_food
    when 'status' then display_status
    when 'relax' then relax
    when 'exit' then
      puts "Exiting..."
      sleep(2)
      exit
    else
      invalid_input("main menu")
    end
  end

  def add_new_field
    puts "What kind of field is it: corn, wheat, or weed?"
    input_type = gets.chomp.downcase

    while input_type != "corn" && input_type != "wheat" && input_type != "weed"
      invalid_input("field type")
      input_type = gets.chomp.downcase
    end

    type = input_type

    puts "How large is the field in hectares?"
    input_area = gets.chomp.to_i

    while input_area == 0
      invalid_input("field area")
      input_area = gets.chomp.to_i
    end

    area = input_area

    # area = input_area.to_i

    puts "Added a #{type} field of #{area} hectares!"

    new_field = Field.new(type, area)
    @fields << new_field
  end

  def collect_food
    if @fields == []
      puts "You have no fields."
    else
      total_harvest = 0

      @fields.each do |field|
        puts "Harvesting #{field.food} from a #{field.area} hectare #{field.type} field."
        total_harvest += field.food
      end

      @total_food_ever += total_harvest
      puts "The farm has #{total_food_ever} harvested 'food' so far."
    end
  end

  def display_status
    @fields.each do |field|
      puts "#{field.type.capitalize} field is #{field.area} hectares."
    end
    puts "The farm has #{@total_food_ever} harvested food so far."
  end

  def collect_area(type)
    total_type_hectares = 0
    @fields.each do |field|
      if field.type == type
        total_type_hectares += field.area
      end
    end
    return total_type_hectares
  end

  def relax
    unless collect_area("corn") == 0
      puts "#{collect_area("corn")} hectares of tall green stalks rustling in the breeze fill your horizon."
    end

    unless collect_area("wheat") == 0
      puts "The sun hangs low, casting an orange glow on a sea of #{collect_area("wheat")} hectares of wheat."
    end

    unless collect_area("weed") == 0
      puts "Something doesn't feel quite the same. You can't put your finger on it, but your mind is somehow at ease overlooking the #{collect_area("weed")} hectares of weed."
    end
  end

  def invalid_input(context)
    if context == 'main menu'
      puts "Invalid option, try again:"

    elsif context == "field type"
      puts "Invalid field type, try again:"

    elsif context == "field area"
      puts "Invalid area, try using whole numbers:"
    end
  end

end

farm = Farm.new

farm.main_menu
