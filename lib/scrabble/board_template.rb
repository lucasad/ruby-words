module Scrabble

##
# A template allows the board to dynamically grow
class BoardTemplate
    ##
    # This is the only function that must be implemented, it returns the cell that should occupy the position passed to it
    def at x,y 
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
    
        def at x,y 
            @grid[y% @height][x% @width]
        end
    end
end
end
