require 'scrabble/board'
require 'engine/drawable'

module Scrabble
class BoardViewport
    attr_accessor :w, :h
    def initialize **kw
        @board = kw[:template]
        @placed = kw[:placed]
        @pending = kw[:pending]

        @origin = [0,0]
        self.w=600
        self.h=600
    end

    def w=(width)
        @width = (width+Space.size-1)/Space.size
        @texture = @texture.destroy if @texture
        render
        @w = width
    end

    def h= height 
        @height = (height+Space.size-1)/Space.size
        @texutre =  @texture.destroy if @texture
        render
        @h = height
    end

    def at x,y
        x,y = x-@origin[0],y-@origin[1]
        x /= Space.size+1
        y /= Space.size+1
        [x,y]
    end

    def draw renderer
        x,y = @origin
        (y..y+@height).each{ |y|
            (x..x+@width).each {|x|
                place renderer, @board.at(x,y).draw(renderer), x*(Space.size+1), y*(Space.size+1)
            }
        }
        for layer in [@placed, @pending] do
            #layer.select { |position, tile| position
            layer.each { |position, tile|
               x,y = position
               place renderer, tile.draw(renderer), x*(Space.size+1), y*(Space.size+1)
            }
        end
    end
    include Engine::Drawable
end
end
