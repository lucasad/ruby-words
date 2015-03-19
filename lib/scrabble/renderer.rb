require 'engine/renderer'

module Scrabble
class Renderer < Engine::Renderer
    def render game
        draw_color=[0,0,0]
        clear
        place game.board_view, 0,0
        place game.rack, 0, game.board_view.h
        if game.selected
            x,y = game.cursor
            place game.selected, x-Space.size/2, y-Space.size/2 
        end
        present
    end

    def construct game
        @game = game
        @game.board_view.w = viewport.w - 123
        @game.board_view.h = viewport.h - 60 
    end
end
end
