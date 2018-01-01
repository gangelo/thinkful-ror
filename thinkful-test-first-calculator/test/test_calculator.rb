require 'test/unit'
require 'test/to_do'
require 'app/calculator'

class TestCalculator < Test::Unit::TestCase
  include ToDo

  def setup
    @it = Calculator.new
  end

  def test_can_add
    actual = @it.add(2, 2)
    assert_equal 4, actual
  end

  def test_can_subtract
    actual = @it.subtract(5, 3)
    assert_equal(2, actual)
  end

  def test_can_multiply
    actual = @it.multiply(3, 3)
    assert_equal(9, actual)
  end

  def test_can_divide
    actual = @it.divide(9, 4)
    assert_equal(2.25, actual)
  end

  def test_edge_case_x
    todo 'Test edge cases.'
  end
end
