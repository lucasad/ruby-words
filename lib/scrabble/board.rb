require 'scrabble/grid'
module Scrabble
class Board
    def initialize(template)
        @template = template
        @cells = Grid.new
    end

    def rect_do rect, &fn
        x,y = rect.position
        w,h = rect.width,rect.height
        ((y...y+h).each_with_index { |y,row|
            (x...x+w).each_with_index { |x,collumn|
                fn.call collumn,row, at(x,y)
            }
        })
        nil
    end

#    private
    def at(x,y)
        @cells.at(x,y) or @template.at(x,y)
    end

    ##
    # Place piece at position
    def place piece, x,y
        cell = at(x,y).dup
        cell.piece = piece
        @cells.place cell, x,y 
    end

end
end
