require 'engine/game'

module Scrabble
class Game < Engine::Game
    attr_reader :board

    def initialize board
        super.initialize
        @board = board
        @state
    end

    #likely unneeded
    def tick
    end
    

end
end
