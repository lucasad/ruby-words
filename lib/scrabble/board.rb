require 'scrabble/grid'

class Board
    def initialize(template)
        @template = template
        @cells = Grid.new
    end

    #def

    private
    def get_at(position)
        @cells.at position or @template.at position
    end


end
