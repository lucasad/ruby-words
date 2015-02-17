require "minitest"
require "minitest/autorun"

require "scrabble/cell"
require "scrabble/piece"

class TestCell < Minitest::Test
    def setup
       Scrabble::Piece.values = 
       {
           "EAIONRTLSU" => 1,
           "DG" => 2,
           "BCMP" => 3,
           "FHVWY" => 4,
           "K" => 5,
           "JX" => 8,
           "QZ" => 10
       }.each_with_object({}) { |(letters, value), values|
           letters.each_char { |chr| values[chr] = value }
       }
       
       Scrabble::Piece.frequencies = {
           "E" => 12,
           "AI" => 9,
           "O" => 8,
           "NRT" => 6,
           "LSUD" => 4,
           "G" => 3,
           "BCMPFHVWY" => 2,
           "KJXQZ" => 1
       }.map { |k,v| k.chars * v }.flatten

        @letter = Scrabble::Piece.new("Q")
    end

    def test_letter_mul
        cell = Scrabble::Cell.new :letter,4
        cell.letter = @letter
        assert_equal cell.word_multiplier,1
        assert_equal cell.value, 4*10
    end

    def test_word_mul
        cell = Scrabble::Cell.new :word,4
        assert_equal cell.word_multiplier, 4
        assert_equal cell.value, 0
    end

    def test_normal
        cell = Scrabble::Cell.new :normal
        assert_equal cell.word_multiplier,1
        assert_equal cell.value, 0
    end

end

