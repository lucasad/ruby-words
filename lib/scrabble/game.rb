require 'engine/game'
require 'scrabble/board_viewport'
require 'scrabble/tile'

module Scrabble
class Game < Engine::Game
    attr_reader :board, :board_view, :player, :rack, :score
    attr_accessor :width, :height, :origin
    attr_accessor :selected, :cursor

    def initialize **kwargs 
        @board = kwargs[:board]
        @state
        @board_view = Scrabble::BoardViewport.new kwargs 
        @rack = Rack.new
        @selected = nil
        @cursor = [0,0]
        @score = 0
    end

    #likely unneeded
    def tick inc
    end

    def calculate_viewport width, height
        @board_view.w=width
        @board_view.h=height
        nil
    end

    def turn_end
        if @board.pending_valid?
            p @score, @board.score
            p @score, @board.score
            @score = @score + @board.score
            @board.finalize
            @rack.refill

            @rack.render
            @board_view.render
        else
            @board.cancel.each {|tile| @rack.append tile }

            @rack.render
            @board_view.render
        end
    end
end
end
