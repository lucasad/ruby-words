require "minitest"
require "minitest/autorun"

require "scrabble/piece"

class TestPieces < Minitest::Test
    def setup
       @values = 
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
       
       @frequencies = {
           "E" => 12,
           "AI" => 9,
           "O" => 8,
           "NRT" => 6,
           "LSUD" => 4,
           "G" => 3,
           "BCMPFHVWY" => 2,
           "KJXQZ" => 1
       }.map { |k,v| k.chars * v }.flatten
    end

    def test_all_leters_values_meta
        assert_equal @values.keys.sort, Array("A".."Z")
    end

    def test_all_frequencies_meta
        assert_equal @frequencies.uniq.sort, Array("A".."Z")
    end

    #def test_need_values_set
    #    assert_raises(RuntimeError) { Scrabble::Piece.value_of "H" }
    #end

    #def test_need_frequencies_set
    #    assert_raises(RuntimeError) { Scrabble::Piece.random }
    #end

    def test_value_of
        Scrabble::Piece.values = @values
        letter_a = Scrabble::Piece.new("A")
        assert_equal letter_a.value, 1
        assert letter_a.value.is_a? Numeric
    end

    def test_random
        Scrabble::Piece.frequencies = @frequencies
        assert_kind_of String, Scrabble::Piece.random
        letter = Scrabble::Piece.new
        assert_kind_of Scrabble::Piece, letter
        assert_kind_of String, letter.letter 
    end
end

