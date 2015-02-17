require 'minitest'
require 'minitest/autorun'

require 'scrabble/player'
require 'scrabble/piece'

class TestPlayer < Minitest::Test
    def setup
        @player = Scrabble::Player.new "name"
    end

    def test_name
        assert_equal "name", @player.name
        assert_kind_of(String, @player.name)
    end

    def test_points
        assert_equal 0, @player.score

        @player.add_points(5)
        assert_equal 5, @player.score

        @player.add_points(5)
        assert_equal 10, @player.score

        assert_raises(TypeError) {  @player.add_points(nil) }
    end
end

class TestRack < Minitest::Test
    def setup
        @rack = Scrabble::Rack.new
    end

    def test_add_letter
        assert_kind_of Scrabble::Rack, @rack.add_letter(Scrabble::Piece.new "A")
        assert_kind_of Scrabble::Rack, @rack.add_letter(Scrabble::Piece.new "B")
        assert_kind_of Scrabble::Rack, @rack.add_letter(Scrabble::Piece.new "C")

        assert_equal 3, @rack.count
    end

    def test_each
        assert_kind_of Enumerable, @rack.each
        letters = ["A","B","C"]
        letters.each {|letter| @rack.add_letter letter }
        @rack.each {|letter|
            assert_equal letters.shift, letter
        }
    end

    def test_remove
        letters = ["A","B","A","C"]
        letters.each {|letter| @rack.add_letter letter }
        @rack.remove letters[2]
        assert_equal ["A","B","C"], @rack.each.to_a
    end

    def test_count
        assert_kind_of Numeric, @rack.count
        assert_equal 0, @rack.count
    end
end
