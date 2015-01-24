module Scrabble
class Cell
    attr_reader :used, :letter, :type, :multiplier
    def initialize(type=:normal, multiplier=1)
        @type = type
        @multiplier = multiplier
    end

    def letter= letter
        raise "Cannot change letter" if @letter
        @letter = letter
    end

    def value
        return 0 unless @letter
        @letter.value * if @type == :letter then @multiplier else 1 end 
    end

    def word_multiplier
        if @used or @type != :word then
            1
        else
            @multiplier
        end
    end
end
end
