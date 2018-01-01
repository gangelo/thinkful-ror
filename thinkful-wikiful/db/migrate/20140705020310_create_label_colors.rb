class CreateLabelColors < ActiveRecord::Migration
  def change
    create_table :label_colors do |t|
      t.string :color, limit: 7
      t.string :background_color, limit: 7

      t.timestamps
    end
  end
end
