require 'ffi/hunspell'
module Scrabble
class PendingWords
    Left = [-1, 0]
    Right = [1,0]
    Bottom = [0,1]
    Top = [0,-1]

    def initialize pending, placed, board 
        @pending = pending
        @placed = placed
        @board = board

        @vertical = {}
        @horizontal = {}
    end

    def reset
        @vertical.clear
        @horizontal.clear
        nil
    end


    def place position
        x,y = position

        leftmost = most(position, Left)
        rightmost= most(position, Right)
        topmost= most(position, Top)
        bottommost= most(position, Bottom)

        p leftmost

        (leftmost[0]..rightmost[0]).each {|x| @horizontal.delete [x,y]}
        (topmost[1]..bottommost[1]).each {|y| @vertical.delete [x,y]}

        @horizontal[leftmost] = rightmost[0]
        @vertical[topmost] = bottommost[1] 
    end

    def score
        h = @horizontal.reject { |(x,y),r| x==r }
        v = @vertical.reject { |(x,y),r| y==r }
    
        hs = h.map { |position,right|
            x,y = position
            value, mult = (x..right).reduce([0,1]) { |(total, word_multiple),x|
                value = @board.tile_at([x,y]).value
                word_multiplier = 1

                if @pending.at(x,y)
                    space = @board.at(x,y)
                    value *= space.letter_multiplier
                    word_multiplier = space.word_multiplier
                end
                [total+value, word_multiple*word_multiplier]
            }
            value*mult
        }
        vs = v.map { |position,bottom|
            x,y = position
            value, mult = (y..bottom).reduce([0,1]) { |(total, word_multiple),y|
                value = @board.tile_at([x,y]).value
                word_multiplier = 1

                if @pending.at(x,y)
                    space = @board.at(x,y)
                    value *= space.letter_multiplier
                    word_multiplier = space.word_multiplier
                end
                [total+value, word_multiple*word_multiplier]
            }
            value*mult
        }
        (hs.reduce(:+)||0) + (vs.reduce(:+)||0) 
    end

    def all_valid 
        h = @horizontal.reject { |(x,y),r| x==r }
        v = @vertical.reject { |(x,y),r| y==r }

        words = h.map { |position,right|
            x,y = position
            (x..right).map { |x| @board.tile_at([x,y]) }
        }
        words.concat v.map {|position, bottom|
            x,y = position
            p [y,bottom]
            (y..bottom).map { |y| @board.tile_at([x,y]) }
        }

        FFI::Hunspell.dict do |dict|
            for word in words do
                word = (word.map {|tile| tile.letter}).join.downcase
                return false unless dict.check? word
            end
        end
        return true
    end 

    private
    def most(position, direction)
        loop do
            next_position = position.zip(direction).map {|c,d| c+d}
            return position unless  @board.occupied(next_position)
            position = next_position
        end
    end
end
end
