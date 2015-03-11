require 'engine/text'
require 'engine/drawable'

module Scrabble
class Piece
    class << self
        attr_accessor :values, :frequencies
        attr_reader :letter
        def random
            raise "Piece frequency not set" unless @frequencies
            @frequencies.sample
        end

        def value_of(letter)
            raise "Point values unset" unless @values
            @values[letter]
        end
    end

    attr_reader :letter, :background
    def initialize(letter=Piece.random)
        @letter = letter
        @background = [0xEE,0xEE,0xCC]
    end

    def value
        Piece.value_of @letter
    end

    def w
        Cell.size
    end
    def h
        Cell.size
    end

    def draw renderer
        renderer.draw_color = background
        renderer.fill_rect renderer.viewport
        @text ||= Engine::Text.new letter
        place_center renderer, @text.draw(renderer) 
    end
    
    include Engine::Drawable
end
end
