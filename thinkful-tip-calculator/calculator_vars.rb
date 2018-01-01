
module Thinkful
  module TipCalculator
    
    class CalculatorVars

      def initialize(meal_amount, tax_percent, tip_percent)
        @meal_amount, @tax_percent, @tip_percent = meal_amount, tax_percent, tip_percent
      end

      # Meal amount
      def meal_amount
        @meal_amount
      end

      # Tax amount
      def tax_percent
        @tax_percent
      end

      # Tip percent
      def tip_percent
        @tip_percent
      end

      protected

      def meal_amount=(value)
        @meal_amount = value
      end

      def tax_percent=(value)
        @tax_percent = value
      end

      def tip_percent=(value)
        @tip_percent = value
      end
    end

  end
end
