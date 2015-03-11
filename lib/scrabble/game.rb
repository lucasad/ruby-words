require 'engine/game'
require 'scrabble/board_viewport'
require 'scrabble/piece'

module Scrabble
class Game < Engine::Game
    attr_reader :board, :board_view, :player
    attr_accessor :width, :height, :origin

    def initialize board
        @board = board
        @state
        @board_view = Scrabble::BoardViewport.new board
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
