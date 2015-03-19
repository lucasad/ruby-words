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

        # Cache the text updates, rendering text is kinda slow
        score_text = "Score: #{@game.score} +#{@game.board.score}"
        @score.text = score_text unless @score.text == score_text

        place @score, (Space.size+1)*7, game.board_view.h

        present
    end

    def construct game
        @game = game
        @game.board_view.w = viewport.w - 123
        @game.board_view.h = viewport.h - 60 

        @score = Engine::Text::new "0", :color => [0xff,0xff,0xff]
    end
end
end
