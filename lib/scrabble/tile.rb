require 'engine/text'
require 'engine/drawable'

Small = SDL2::TTF::open "/usr/share/fonts/dejavu/DejaVuSansMono-Bold.ttf", 10

module Scrabble
class Tile
    class << self
        attr_accessor :values, :frequencies
        attr_reader :letter
        def random
            raise "Tile frequency not set" unless @frequencies
            @frequencies.sample
        end

        def value_of(letter)
            raise "Point values unset" unless @values
            @values[letter]
        end
    end

    attr_reader :letter, :value
    attr_reader :w, :h
    def initialize(letter=Tile.random)
        @letter = letter
        @w = @h = Space.size
        @value = Tile.value_of letter
    end

    def draw renderer
        renderer.draw_color = [0xcc,0xcc,0xcc]
        renderer.fill_rect renderer.viewport
        @text ||= Engine::Text.new letter
        @val_text ||= Engine::Text.new value.to_s, :font => Small

        place renderer, @val_text.draw(renderer), 25,25 
        place_center renderer, @text.draw(renderer) 
    end

    def inspect
        "#{@letter}_#{@value}"
    end
    
    include Engine::Drawable
end
end
