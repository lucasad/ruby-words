module Scrabble
class Rack
    attr_reader :w, :h
    ##
    # Create a new rack with 7 tiles
    def initialize
        @letters = (1..7).map { || Tile.new }
        @h = Space.size
        @w = (Space.size+1)*7
    end
   
    ##
    # Add a letter to the rack 
    def append letter 
        @letters << letter  
        self
    end

    ##
    # Refills the rack so that it has 7 tiles again
    def refill
        @letters.concat (count..7).map { Tile::new }
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

    ##
    # Get the letter at the index
    # @param index [Fixnum]
    def get index
        @letters[index]
    end

    def draw renderer
        p "drawing rack"
        renderer.draw_color = [0,0,0]
        renderer.clear
        @letters.each_with_index {|tile, i|
            place renderer, tile.draw(renderer), i*(Space.size+1), 0
        }
    end

    include Engine::Drawable
end
end
