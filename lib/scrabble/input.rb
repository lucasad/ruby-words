require 'engine/input'
module Scrabble
class Input < Engine::Input
    include Engine::Input::MouseInput
    include Engine::Input::WindowInput
    include Engine::Input::TextInput

    def initialize game, window
        @game = game
        @window = window
        mouse_init 0
        window_init
    end

    def mouse_press button
    end

    def text_input text
        pos = @game.board_view.at @x,@y
        @game.board.place Piece.new(text), *pos unless @game.board.at(*pos).piece
        @game.board_view.render
    end

    def window_resized width, height
        @game.calculate_viewport width, height
    end
    def window_close
        RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT)
        exit
    end

end
end
