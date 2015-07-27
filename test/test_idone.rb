require 'minitest/autorun'
require 'donerunner'
require 'done'

class HolaTest < Minitest::Test
  def test_sorts
    array = [ 
      Done.new("sample1", Date.new(2012,01,01)),
      Done.new("sample2", Date.new(2012,01,03)), 
      Done.new("sample3", Date.new(2012,01,02)) 
    ]

    expected_result = [
      Date.new(2012,01,03),
      Date.new(2012,01,02),
      Date.new(2012,01,01) 
    ]

    assert_equal expected_result,
      DoneRunner.group_and_sort(array).keys
  end

def test_sorts_today
    array = [ 
      Done.new("sample1", Date.new(2012,01,01)),
      Done.new("sample2", Date.new(2012,01,03)), 
      Done.new("sample3", Date.new(2012,01,02)) 
    ]

    expected_result = [
      Date.new(2012,01,03)
    ]

    assert_equal expected_result,
      DoneRunner.group_and_sort(array, 1).keys
  end
 

def test_groups
    array = [ 
      Done.new("sample1", Date.new(2012,01,01)),
      Done.new("sample2", Date.new(2012,01,03)), 
      Done.new("sample3", Date.new(2012,01,02)) 
    ]

    expected_result = {
      Date.new(2012,01,03) => [Done.new("sample2", Date.new(2012,01,03))],
      Date.new(2012,01,02) => [Done.new("sample3", Date.new(2012,01,02))],
      Date.new(2012,01,01) => [Done.new("sample1", Date.new(2012,01,01))]
    }

    assert_equal expected_result,
      DoneRunner.group_and_sort(array)
  end

end