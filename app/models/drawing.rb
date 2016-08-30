class Drawing < ApplicationRecord
  belongs_to :drawing_time

  def self.overall_breakdown
    [
      group(:first_ball).count,
      group(:second_ball).count,
      group(:third_ball).count
    ]
  end

  def self.breakdown_by_drawing(draw_time)
    [
      DrawingTime.find_by(title: draw_time).drawings.group(:first_ball).count,
      DrawingTime.find_by(title: draw_time).drawings.group(:second_ball).count,
      DrawingTime.find_by(title: draw_time).drawings.group(:third_ball).count
    ]
  end

  def self.number_qualifer(breakdown)
    breakdown.mean - breakdown.standard_deviation
  end

  def self.candidate_numbers(breakdown)
    numbers = []
    benchmark = number_qualifer(breakdown)
    breakdown.each do |key, value|
      numbers << key if value < benchmark
    end
    numbers.sort
  end
end
