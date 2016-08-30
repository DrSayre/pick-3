class DrawingTime < ApplicationRecord
  has_many :drawings

  def wheel
    overall = overall_numbers
    time = drawing_time_numbers
    sort_and_remove_duplicates(overall, time)
  end

  def overall_numbers
    overall = Drawing.overall_breakdown
    [
      Drawing.candidate_numbers(overall[0]),
      Drawing.candidate_numbers(overall[1]),
      Drawing.candidate_numbers(overall[2])
    ]
  end

  def drawing_time_numbers
    time = Drawing.breakdown_by_drawing(title)
    [
      Drawing.candidate_numbers(time[0]),
      Drawing.candidate_numbers(time[1]),
      Drawing.candidate_numbers(time[2])
    ]
  end

  def sort_and_remove_duplicates(overall_numbers, draw_numbers)
    [
      (overall_numbers[0] + draw_numbers[0]).uniq.sort,
      (overall_numbers[1] + draw_numbers[1]).uniq.sort,
      (overall_numbers[2] + draw_numbers[2]).uniq.sort
    ]
  end

  def self.next_drawing
    hour = Time.now.hour
    minute = Time.now.min
    if hour == 13
      return 'Midday' if minute < 30
      return 'Evening'
    end
    if hour == 23
      return 'Evening' if minute < 10
      return 'Midday'
    end
    return 'Midday' if hour < 13
    'Evening'
  end

  def self.next_drawing_date
    return Date.today + 1.day if (Time.now.min > 10) && (Time.now.hour == 23)
    Date.today
  end
end
