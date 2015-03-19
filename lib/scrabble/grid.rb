require 'scrabble/structs'

module Scrabble
class Grid
    def initialize
        @grid = Hash.new
    end

    def place item, x,y 
        @grid[[x,y]] = item
    end

    def at x,y 
        @grid[[x,y]]
    end

    def each &fn
        @grid.each &fn
    end

    def clear
        values = @grid.values
        @grid.clear
        values
    end

    def in_rect rect, &fn
        x,y = rect.position.x, rect.position.y 
        w,h = rect.width, rect.height

        (x...x+w).map { |x|
            (y...y+h).map { |y|
                position = Position.new x,y
                item =  @grid[position]
                [position,item] if item
                
            }
        }.flatten(1).compact.each &fn
    end
end
end
