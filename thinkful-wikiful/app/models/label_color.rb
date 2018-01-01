class LabelColor < ActiveRecord::Base
  validates_uniqueness_of :color, :scope => :background_color
end
