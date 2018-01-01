class AddLabelColorReferenceToCategory < ActiveRecord::Migration
  def change
    add_reference :categories, :label_color, index: true
  end
end
