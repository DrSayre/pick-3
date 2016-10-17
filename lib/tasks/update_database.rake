def save_three_numbers(results, draw)
  time = DrawingTime.find_or_create_by title: draw
  results.each do |result|
    results_row = result.css('td')
    numbers = results_row[2].css('span').text.strip
    winning_numbers = numbers.scan(/\d/)
    drawing_date = Date.strptime(results_row[1].text,"%m/%d/%Y")
    begin
      Drawing.create(drawing_date: drawing_date, first_ball: winning_numbers[0], second_ball: winning_numbers[1], third_ball: winning_numbers[2], drawing_time_id: time.id) if numbers.match /^\d/
    rescue
      nil
    end
  end
end

task :update_database do
  agent = Mechanize.new

  html = agent.get('http://www.kylottery.com/apps/draw_games/pick3/pick3_pastwinning.html').body

  midday_results = Nokogiri::HTML(html).css('table table')[0].css('tbody').css('tr')
  night_results = Nokogiri::HTML(html).css('table table')[1].css('tbody').css('tr')

  save_three_numbers(midday_results, 'Midday')

  save_three_numbers(night_results, 'Evening')
end