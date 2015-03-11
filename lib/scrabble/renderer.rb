require 'engine/renderer'

module Scrabble
class Renderer < Engine::Renderer
    def render game
        clear
        place game.board_view, 0,0
        present
    end

end
end
