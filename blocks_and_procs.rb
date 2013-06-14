# Proc.new, lambda, ->

class Library
  attr_accessor :games
  def initialize(games)
    @games = games
  end
  
  def exec_game(name, action, error)
    game = games.find {|game| game.name == name}
    begin 
      action.call(game)
    rescue
      error.call
    end
  end
  
end

#####

Game = Struct.new(:name)
library = Library.new([Game.new("Contra")])

print_details = Proc.new do |game|
  puts " => #{game.name}"
end
error_handler = lambda { puts "Oh no, there was an error!" }

library.exec_game("Contra", print_details, error_handler)