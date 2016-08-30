class CreateDrawingTimes < ActiveRecord::Migration[5.0]
  def change
    create_table :drawing_times do |t|
      t.string :title

      t.timestamps

    end
    DrawingTime.create(title: 'Midday')
  	DrawingTime.create(title: 'Evening')
  end
end
