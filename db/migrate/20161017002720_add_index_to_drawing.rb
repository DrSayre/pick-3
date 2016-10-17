class AddIndexToDrawing < ActiveRecord::Migration[5.0]
  def change
    add_index :drawings, [:drawing_date, :drawing_time_id], unique: true
  end
end
