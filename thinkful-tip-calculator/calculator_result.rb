
module Thinkful
  module TipCalculator

  	class CalculatorResult
  		attr_reader :meal_amount, :tip_amount, :grand_total

  		def initialize(meal_amount, tip_amount, grand_total)
  			@meal_amount, @tip_amount, @grand_total = meal_amount, tip_amount, grand_total
  		end
  	end
  end
end