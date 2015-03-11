require 'engine/drawable'

module Scrabble
class Cell
    class << self
        attr_accessor :size
    end
    def w
        Cell.size
    end
    def h
        Cell.size
    end
    self.size = 30

    attr_reader :used, :piece, :type, :multiplier
    def initialize(type=:normal, multiplier=1)
        @type = type
        @multiplier = multiplier
        @text = Engine::Text.new inspect, :color => [0,0,0]
    end

    def piece= piece
        raise "Cannot change piece" if @piece
        @piece = piece 
        render
    end

    def value
        return 0 unless @piece
        @piece.value * if @type == :piece and not @used then @multiplier else 1 end 
    end

    def word_multiplier
        if @used or @type != :word then
            1
        else
            @multiplier
        end
    end

    def use
        @used = true
    end

    def inspect
        return piece.inspect if piece
        case @type
            when :letter
                "#{@multiplier}LS"
            when :word
                "#{@multiplier}WS"
            else
                "   "
            end
    end

    def draw renderer
        renderer.draw_color = background 
        renderer.fill_rect renderer.viewport


        if @piece then
            place_center renderer, piece.draw(renderer)
            renderer.draw_color = background
        else
            place_center renderer, @text.draw(renderer) 
            renderer.draw_color = [0,0,0]
        end

        renderer.draw_rect renderer.viewport

        @texture
    end

    private 
    def background
        case @type
        when :normal
            [255,255,255]
        when :letter
            case @multiplier.to_i
            when 2
                [0x55,0xcc,0xff]
            when 3
                [0x00,0x55,0xff]
            end
        when :word
            case @multiplier.to_i
            when 2
                [0xff,0x55,0xcc] 
            when 3
                [0xff,0x00,0x55]
            end
        end
    end
    include Engine::Drawable
end
end
