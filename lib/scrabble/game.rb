require 'engine/game'
require 'scrabble/board_viewport'
require 'scrabble/tile'

module Scrabble
class Game < Engine::Game
    attr_reader :board, :board_view, :player, :rack
    attr_accessor :width, :height, :origin
    attr_accessor :selected, :cursor

    def initialize **kwargs 
        @board = kwargs[:board]
        @state
        @board_view = Scrabble::BoardViewport.new kwargs 
        @rack = Rack.new
        @selected = nil
        @cursor = [0,0]
    end

    #likely unneeded
    def tick inc
    end

    def calculate_viewport width, height
        @board_view.w=width
        @board_view.h=height
        nil
    end

    def visible_cells &fn
        @board.rect_do Rect.new(@origin, @width, @height), &fn
    end
end
end
