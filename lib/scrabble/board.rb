require 'scrabble/grid'
module Scrabble
class Board

    ##
    # Create an new board
    # @param pending [Grid] The pieces that haven't been validated and aren't fully commited yet
    # @param placed [Grid] The pieces on the board that have been placed
    # @param template [Template] The template for the background spaces
    def initialize(pending, placed, template)
        @pending = pending
        @placed = placed
        @template = template
        @pending_words = PendingWords.new(@pending, @placed, self)
    end

    ##
    # Place piece at position
    def place piece, x,y
        @pending_words.place [x,y]
        @pending.place piece, x,y 
    end


    ##
    # Determines if there is a tile at the position
    def occupied(position)
        !!tile_at(position)
    end

    ##
    # Return the spaces horizontal and vertical 
    def get_adjacent(position)
        x,y = position
        [tile_at([x+1,y]),
         tile_at([x-1,y]),
         tile_at([x,y+1]),
         tile_at([x,y-1])]
    end

    def at(x,y)
        @template.at(x,y)
    end

    def score
        p @pending_words.score
    end

    ##
    # Determine if it is connected
    def adjacent?(position)
        get_adjacent(position).compact > 1
    end

    ##
    # Gets the tile at the position
    # @param [
    def tile_at(position)
        @placed.at(*position) or @pending.at(*position)
    end

    def add_pieces(pieces)
        pieces.each {|k,v| @placed[k] = v }
        nil
    end

    def finalize
        add_pieces pending
        @pending.clear
    end


end
end
