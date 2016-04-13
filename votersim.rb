require_relative 'person'

class Votersim
  def initialize
    @list_politicians = []
    @list_voters = []
  end

  def main_menu
    puts "What would you like to do?"
    puts "(C)reate, (L)ist, (U)pdate, (D)elete, or (Q)uit"

    get_input("C", "L", "U", "D", "Q")
    options_select("create", "list", "update", "delete", "quit")
  end
  def create
    puts "What would you like to create?"
    puts "(P)olitician or (V)oter"
    get_input("P", "V")
    options_select("create_politician", "create_voter")
    get_input("P", "V")
  end
  def create_politician
    puts "Enter name"
    @name = gets.chomp.split.map(&:capitalize).join(' ')
    puts 'Enter political party'
    puts "(R)epublican or (D)emocrat"
    @party = political_party(get_input("R", "D"))
    @list_politicians << Politician.new(@name,@party)
    puts "Youve created #{@name}, a #{@party}"
    main_menu
  end
  def create_voter
    puts "Enter name"
    @name = gets.chomp.split.map(&:capitalize).join(' ')
    puts "Enter politicial affiliation"
    puts "(L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral"
    @party = political_party(get_input("L", "C", "T", "S", "N"))
    @list_voters << Voter.new(@name,@party)
    puts "Youve created #{@name}, a #{@party}"
    main_menu
  end
  def political_party(party_entered)
    case party_entered
    when "R"
      "Republican"
    when "D"
      "Democrat"
    when "L"
      "Liberal"
    when "C"
      "Conservative"
    when "T"
      "Tea Party"
    when "S"
      "Socialist"
    when "N"
      "Neutral"
    end
  end
  def list
    puts "~~~~Voters~~~~"
    @list_voters.each do |i|
      puts "#{i.name}, #{i.party}"
    end
    puts ''
    puts "~~Politicians~~"
    @list_politicians.each do |i|
      puts "#{i.name}, #{i.party}"
    end
    sleep(1)
    main_menu
  end
  def update
    puts "Who would you like to update?"
    @name = gets.chomp.split.map(&:capitalize).join(' ')
    @list_politicians.each do |i|
      if @name = i.name
        puts "New Name?"
        i.name = gets.chomp
        puts "New Party?"
        puts "(R)epublican or (D)emocrat?"
        get_input("R", "D")
        i.party = political_party(@input)
        main_menu
      end
    end
    @list_voters.each do |i|
      if @name = i.name
        puts "New name?"
        i.name = gets.chomp
        puts "New politics?"
        puts "(L)iberal, (C)onservative, (T)ea Party, (S)ocialist, or (N)eutral"
        get_input("L", "C", "T", "S", "N")
        i.party = political_party(@input)
        main_menu
      end
    end
    puts "No one by that name found!"
    main_menu
  end
  def quit
    puts "Thank you for using Voting Simulator 9000 "
  end
  def delete
   puts "Please choose to delete a Voter (V) or Politician (P) ?"
   answer4 = gets.chomp.downcase
  #  puts "Are you sure you want to delete? (Y)es or (N)o"
   case answer4
   when "v"
     puts "Name of the person you want to delete?"
     delete_person = gets.chomp.split.map(&:capitalize).join(' ')
     puts "Are you sure you want to delete? (Y)es or (N)o"
     answer5 = gets.chomp.downcase
     if answer5 == "y"
       @list_voters.delete_if { |v| v.name == delete_person }
     else
     main_menu
   end

   when "p"
     puts "Name of the politician you want to delete?"
     delete_politician = gets.chomp.split.map(&:capitalize).join(' ')
     puts "Are you sure you want to delete? (Y)es or (N)o"
     answer5 = gets.chomp.downcase
     if answer5 == "y"
       @list_politicians.delete_if { |l| l.name == delete_politician }
     else
       main_menu
   end
   main_menu
 end

end
  def options_select(*possible_options)
      answer_index = @answers.index(@input)
      eval(possible_options[answer_index])
  end
  def get_input(*possible_answers)
    @answers = possible_answers
    @input = gets.chomp.capitalize
    valid_response = false
    @answers.each do |i|
      if @input == i
        valid_response = true
      end
    end
    if valid_response == true
      @input
    else
      puts "Invalid Answer"
      main_menu
     end
  end
end

sim = Votersim.new
sim.main_menu
