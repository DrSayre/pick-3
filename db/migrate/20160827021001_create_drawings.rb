class CreateDrawings < ActiveRecord::Migration[5.0]
  def change
    create_table :drawings do |t|
      t.integer :first_ball
      t.integer :second_ball
      t.integer :third_ball
      t.references :drawing_time, foreign_key: true
      t.date :drawing_date

      t.timestamps
    end
  end
end
