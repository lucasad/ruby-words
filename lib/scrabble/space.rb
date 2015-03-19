require 'engine/drawable'

module Scrabble
class Space
    class << self
        attr_accessor :size
    end
    def w
        Space.size
    end
    def h
        Space.size
    end
    self.size = 30

    attr_reader :type, :letter_multiplier, :word_multiplier 
    def initialize(type=:normal, multiplier=1)
        @type = type
        @letter_multiplier=1
        @word_multiplier=1

        case type
            when :letter
                @letter_multiplier = multiplier
            when :word
                @word_multiplier = multiplier 
        end
        @text = Engine::Text.new inspect, :color => [0,0,0]
    end

    def inspect
        case @type
            when :letter
                "#{@letter_multiplier}LS"
            when :word
                "#{@word_multiplier}WS"
            else
                "   "
            end
    end

    def draw renderer
        renderer.draw_color = background 
        renderer.fill_rect renderer.viewport

        place_center renderer, @text.draw(renderer) 
        @texture
    end

    private 
    def background
        case @type
        when :normal
            [255,255,255]
        when :letter
            case @letter_multiplier.to_i
            when 2
                [0x55,0xcc,0xff]
            when 3
                [0x00,0x55,0xff]
            end
        when :word
            case @word_multiplier.to_i
            when 2
                [0xff,0x55,0xcc] 
            when 3
                [0xff,0x00,0x55]
            end
        else
            [0x00,0xff,0x00]
        end
    end
    include Engine::Drawable
end
end
