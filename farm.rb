require './field.rb'
require './pasture.rb'
require 'ap'
require 'pp'

class Farm

  def initialize
    @fields = []
    @pastures = []
    @total_food_ever = 0
    @total_animals = 0
  end

  def fields
    @fields
  end

  def pastures
    @pastures
  end

  def total_food_ever
    @total_food_ever
  end

  def total_animals
    @total_animals
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
    puts 'pasture -> adds a new pasture'
    puts 'harvest -> harvests crops and adds to total harvested'
    puts 'status -> displays some information about the farm'
    puts 'relax -> provides lovely descriptions of your fields'
    puts 'exit -> exits the program'
  end

  def call_option(user_selected)
    case user_selected
    when 'field' then add_new_field
    when 'pasture' then add_new_pasture
    when 'harvest' then harvest
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

    ### TYPE
    puts "What kind of field is it: corn, wheat, or weed?"
    input_type = gets.chomp.downcase

    while input_type != "corn" && input_type != "wheat" && input_type != "weed"
      invalid_input("field type")
      input_type = gets.chomp.downcase
    end

    type = input_type

    ### AREA
    puts "How large is the field in hectares?"
    input_area = gets.chomp.to_i

    while input_area == 0
      invalid_input("field area")
      input_area = gets.chomp.to_i
    end

    area = input_area

    ### OUTPUT
    puts "Added a #{type} field of #{area} hectares!"

    @fields << Field.new(type, area)
  end

  def add_new_pasture

    ### TYPE
    puts "What kind of pasture is it: cows or chickens?"
    input_type = gets.chomp.downcase

    while input_type != "cows" && input_type != "chickens"
      invalid_input("pasture type")
      input_type = gets.chomp.downcase
    end

    type = input_type

    ### NUMBER OF ANIMALS
    if type == "chickens"
      puts "How many chickens to start off with?"
    else
      puts "How many cows to start off with?"
    end
    input_number = gets.chomp.to_i

    while input_number == 0
      invalid_input("number of animals")
      input_number = gets.chomp.to_i
    end

    number = input_number

    ### OUTPUT
    puts "Added a pasture with #{number} #{type}!"

    @pastures << Pasture.new(type, number)
  end

  def harvest
    if @fields == [] && @pastures == []
      puts "You have no fields or pastures."
    else
      total_harvest = 0
      total_animals_this_harvest = 0

      unless @fields == []
        @fields.each do |field|
          puts "Harvesting #{field.food} from a #{field.area} hectare #{field.type} field."
          total_harvest += field.food
        end
        @total_food_ever += total_harvest
      end

      unless @pastures == []
        @pastures.each do |pasture|
          old_number_of_animals = pasture.number_of_animals

          pasture.produce_offspring

          puts "The #{pasture.type} have made #{pasture.number_of_animals - old_number_of_animals} babies! There are now #{pasture.number_of_animals} #{pasture.type} on the pasture."

          total_animals_this_harvest += (pasture.number_of_animals - old_number_of_animals)
        end
        @total_animals += total_animals_this_harvest
      end

      puts "The farm has #{total_food_ever} harvested 'food' so far and #{@total_animals} born animals."
    end
  end

  def display_status
    @fields.each do |field|
      puts "#{field.type.capitalize} field is #{field.area} hectares."
    end

    @pastures.each do |pasture|
      puts "You have #{pasture.number_of_animals} #{pasture.type} on the pasture."
    end

    unless @fields == [] && @pastures == []
      puts "The farm has #{@total_food_ever} harvested food so far."
      puts "The farm has #{@total_animals} animals born so far."
    end

    if @fields == [] && @pastures == []
      puts "Your farm is empty."
    end
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

  def collect_animals(type)
    total_type_animals = 0
    @pastures.each do |pasture|
      if pasture.type == type
        total_type_animals += pasture.number_of_animals
      end
    end
    return total_type_animals
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

    unless collect_animals("cows") == 0
      puts "You love your cows. They are your friends! You have #{collect_animals("cows")} cows."
    end

    unless collect_animals("chickens") == 0
      puts "You love your chickens. They are also your friends! You have #{collect_animals("chickens")} chickens."
    end
  end

  def invalid_input(context)
    if context == 'main menu'
      puts "Invalid option, try again:"

    elsif context == "field type"
      puts "Invalid field type, try again:"

    elsif context == "field area"
      puts "Invalid area, try using whole numbers:"

    elsif context == "pasture type"
      puts "Invalid pasture type, try again:"

    else
      puts "Invalid number of animals, try a positive integer:"
    end
  end

end

farm = Farm.new

farm.main_menu
