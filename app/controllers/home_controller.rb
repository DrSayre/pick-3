class HomeController < ApplicationController
  def index
    @drawing_date = DrawingTime.next_drawing_date
    @drawing_time = DrawingTime.next_drawing
    @numbers = DrawingTime.find_by(title: @drawing_time).wheel
  end
end
