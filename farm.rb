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
    end
  end

  def add_new_field
    puts "What kind of field is it: corn or wheat?"
    type = gets.chomp.downcase
    puts "How large is the field in hectares?"
    area = gets.chomp.to_i
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
    puts "The farm has #{total_food_ever} harvested food so far."
    end
  end

  def display_status
    @fields.each do |field|
      puts "#{field.type.capitalize} field is #{field.area} hectares."
    end
    puts "The farm has #{@total_food_ever} harvested food so far."
  end

  def relax
    total_corn_hectares = 0
    corn_fields = @fields.select do |field|
      field.type == "corn"
    end
    corn_fields.each do |field|
      total_corn_hectares += field.area
    end

    total_wheat_hectares = 0
    wheat_fields = @fields.select do |field|
      field.type == "wheat"
    end
    wheat_fields.each do |field|
      total_wheat_hectares += field.area
    end

    puts "#{total_corn_hectares} hectares of tall green stalks rustling in the breeze fill your horizon."
    puts "The sun hangs low, casting an orange glow on a sea of #{total_wheat_hectares} hectares of wheat."
  end

end

farm = Farm.new
field1 = Field.new("corn", 1000)
field2 = Field.new("wheat", 1000)

farm.main_menu
