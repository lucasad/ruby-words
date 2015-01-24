require 'minitest'
require 'minitest/autorun'

require 'scrabble/board_template'
require 'scrabble/structs'

class TestBoardTemplate < Minitest::Test
    def test_at
        assert_raises(NotImplementedError) { Scrabble::BoardTemplate.new.get_at 3 }
    end
end

class DummyGrid
    def at position
        position.x+position.y
    end
end
class TestTilingTemplate < Minitest::Test
    def setup
    end
    def test_tiling
        template = Scrabble::BoardTemplate::Tiling.new DummyGrid.new, 3,3
        assert_equal template.get_at(Scrabble::Position.new(1,1)), template.get_at(Scrabble::Position.new(4,4))
    end
end
