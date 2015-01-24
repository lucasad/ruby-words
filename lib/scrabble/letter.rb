module Scrabble
class Letter
    class << self
        attr_accessor :values, :frequencies
        def random
            raise "Letter frequency not set" unless @frequencies
            @frequencies.sample
        end

        def value_of(letter)
            raise "Point values unset" unless @values
            @values[letter]
        end
    end

    attr_reader :letter
    def initialize(letter=nil)
        @letter = if letter then letter else
            Letter.random
        end
    end

    def value
        Letter.value_of @letter
    end
end
end
