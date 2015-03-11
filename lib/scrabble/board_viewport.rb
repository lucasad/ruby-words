require 'scrabble/board'
require 'engine/drawable'

module Scrabble
class BoardViewport
    attr_accessor :w,:h
    def initialize board
        @board = board
        @origin = [0,0]
    end

    def w= width
        @width = (width+Cell.size-1)/Cell.size
        @texture = @texture.destroy if @texture
        render
        @w = width
    end

    def h= height 
        @height = (height+Cell.size-1)/Cell.size
        @texutre =  @texture.destroy if @texture
        render
        @h = height
    end

    def at x,y
        x,y = x-@origin[0],y-@origin[1]
        x /= Cell.size
        y /= Cell.size
        [x,y]
    end

    def draw renderer
        @board.rect_do Rect.new(@origin, @width, @height) do |x,y,cell|
            place renderer, cell.draw(renderer), x*Cell.size, y*Cell.size
        end
    end
    include Engine::Drawable
end
end
