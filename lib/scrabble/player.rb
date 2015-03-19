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
end
