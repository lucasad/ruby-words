require 'engine/input'
module Scrabble
class Input < Engine::Input
    include Engine::Input::MouseInput
    include Engine::Input::WindowInput

    def initialize game, view 
        @game = game
        @window = view.window
        mouse_init @window, 0
        window_init @window
    end

    def mouse_move dx,dy
        @game.cursor = [@x,@y]
    end

    def mouse_press button
        unless (0..@game.board_view.h).cover? @y
            x = @x / (Space.size+1)
            if x < @game.rack.count
                @game.selected = @game.rack.get(x)
            end
            @game.board_view.render
        else
            @game.board.score
        end
    end

    def mouse_release button
        if (0..@game.board_view.h).cover? @y and (0..@game.board_view.w).cover? @x
            return unless @game.selected

            position = @game.board_view.at @x,@y
            unless @game.board.occupied(position)
                @game.board.place(@game.selected, *position)
                @game.rack.remove(@game.selected)
                @game.selected = nil
                @game.board_view.render
                @game.rack.render
            end
        end
    end

    def _keyboard event
        case event
        when SDL2::Event::KeyUp
            case event.scancode
                when 21 # <r>
                @game.board.cancel.each {|tile| @game.rack.append tile }
                @game.board_view.render
                when 40 # <enter>
                @game.turn_end
                @game.board_view.render
                else
                p event.scancode
            end
        when SDL2::Event::KeyDown
        end
    end 

    def window_resized width, height
        @game.calculate_viewport width-123, height-60
    end

    def window_close
        RubyProf::FlatPrinter.new(RubyProf.stop).print(STDOUT)
        exit
    end

end
end
