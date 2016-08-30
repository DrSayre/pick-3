require 'test_helper'

class DrawingTest < ActiveSupport::TestCase
  test 'Correct value on overall breakdown for 7 on first ball' do
    count = Drawing.where(first_ball: 7).count
    assert_equal count, Drawing.overall_breakdown[0][7], 'Correct value for 7 on first ball'
  end

  test 'Correct value on overall breakdown for 3 on second ball' do
    count = Drawing.where(second_ball: 3).count
    assert_equal count, Drawing.overall_breakdown[1][3], 'Correct value for 3 on second ball'
  end

  test 'Correct value on overall breakdown for 0 on third ball' do
    count = Drawing.where(third_ball: 0).count
    assert_equal count, Drawing.overall_breakdown[2][0], 'Correct value for 0 on third ball'
  end

  test 'Correct value on midday breakdown for 7 on first ball' do
    count = DrawingTime.find_by(title: 'Midday').drawings.where(first_ball: 7).count
    assert_equal count, Drawing.breakdown_by_drawing('Midday')[0][7], 'Correct value for 7 on first ball'
  end

  test 'Correct value on midday breakdown for 3 on second ball' do
    count = DrawingTime.find_by(title: 'Midday').drawings.where(second_ball: 3).count
    assert_equal count, Drawing.breakdown_by_drawing('Midday')[1][3], 'Correct value for 3 on second ball'
  end

  test 'Correct value on midday breakdown for 0 on third ball' do
    count = DrawingTime.find_by(title: 'Midday').drawings.where(third_ball: 0).count
    assert_equal count, Drawing.breakdown_by_drawing('Midday')[2][0], 'Correct value for 0 on third ball'
  end

  test 'Correct value on evening breakdown for 7 on first ball' do
    count = DrawingTime.find_by(title: 'Evening').drawings.where(first_ball: 7).count
    assert_equal count, Drawing.breakdown_by_drawing('Evening')[0][7], 'Correct value for 7 on first ball'
  end

  test 'Correct value on evening breakdown for 3 on second ball' do
    count = DrawingTime.find_by(title: 'Evening').drawings.where(second_ball: 3).count
    assert_equal count, Drawing.breakdown_by_drawing('Evening')[1][3], 'Correct value for 3 on second ball'
  end

  test 'Correct value on evening breakdown for 0 on third ball' do
    count = DrawingTime.find_by(title: 'Evening').drawings.where(third_ball: 0).count
    assert_equal count, Drawing.breakdown_by_drawing('Evening')[2][0], 'Correct value for 0 on third ball'
  end

  test 'Correct value to consider number' do
    breakdown = { 0 => 1, 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 4, 6 => 3, 7 => 2, 8 => 1, 9 => 0 }
    average = breakdown.mean
    standard_deviation = breakdown.standard_deviation
    qualifing_value = average - standard_deviation
    assert_equal qualifing_value, Drawing.number_qualifer(breakdown), 'returns correct value to consider number'
  end

  test 'Correct numbers from array' do
    breakdown = { 0 => 0, 1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 4, 6 => 3, 7 => 2, 8 => 1, 9 => 0 }
    numbers = Drawing.candidate_numbers(breakdown)
    assert_equal Array, numbers.class, 'returns array of numbers'
    assert_equal [0, 9], numbers, 'returns the correct array of numbers'
  end
end
