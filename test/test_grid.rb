require 'minitest'
require 'minitest/autorun'

require 'scrabble/grid'

class TestGrid < Minitest::Test
    def setup
        @mygrid = Scrabble::Grid.new
    end

    def test_place_at
        item = 3
        location = Scrabble::Position.new 0,0
        assert_equal item, @mygrid.place(item,location)
        assert_equal item, @mygrid.at(location)
    end

    def test_each
        items = (0...9).to_a
        positions = (0...3).map {|x|
            (0...3).map {|y|
                Scrabble::Position.new x,y
            }
        }.flatten
        positions.zip(items).map { |location, item|
             @mygrid.place(item,location)
        }

        @mygrid.each {|position,item|
            positions.delete position
            items.delete item
        }

        assert_equal [], positions
        assert_equal [], items
    end

    def test_each_in
        location = Scrabble::Position.new 0,0
        item = 42
        @mygrid.place item,location 

        rect = Scrabble::Rect.new(Scrabble::Position.new(-1,-1), 3,3)

        found = false
        @mygrid.in_rect(rect).each { |(_loc,_item)|
            assert_equal location, _loc
            assert_equal item, _item
            found = true
        }
        assert found
    end
end
