module Scrabble

##
# A template allows the board to dynamically grow
class BoardTemplate
    ##
    # This is the only function that must be implemented, it returns the cell that should occupy the position passed to it
    def get_at position
    raise NotImplementedError
    end

    ##
    # This is a template that simply tiles the grid
    class Tiling
        def initialize grid, width, height
            @grid = grid
            @width = width
            @height = height
        end
    
        def get_at location 
            x,y = location.x,location.y
            @grid.at(Position.new x% @width, y% @height) 
        end
    end
end
end
