module Scrabble
class Player
    attr_reader :name, :rack, :score
    def initialize name, rack=nil
        @rack = rack || Rack.new
        @name = name 
        @score = 0
    end

    ##
    # Add points to the player's score
    def add_points points
        @score+= points
    end
end

class Rack
    def initialize
        @letters = []
    end
   
    ##
    # Add a letter to the rack 
    def add_letter letter 
        @letters << letter  
        self
    end

    ##
    # Iterates over the letter in order
    def each &fn
        @letters.each &fn
    end

    ##
    # Removes letter from the rack
    def remove letter
        @letters.delete_if { |a_letter| a_letter.__id__ == letter.__id__}
    end

    ##
    # Get the number of letters in a rack
    def count
        @letters.length
    end
end
end
