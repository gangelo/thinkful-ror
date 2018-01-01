
require_relative 'calculator_result'

module Thinkful
  module TipCalculator

  	class Calculator
      attr_reader :calculator_vars

      def initialize(calculator_vars)
        @calculator_vars = calculator_vars
      end

      def calculate
        CalculatorResult.new calc_meal_amount, calc_tip_amount, calc_grand_total
      end

      def print_string
"The pre-tax cost of your meal was #{'$%.2f' % calculator_vars.meal_amount}
At #{'%d%%' % calculator_vars.tax_percent}, tax for this meal is #{'$%.2f' % calc_tax_amount}.
For a #{'%d%%' % calculator_vars.tip_percent} tip, you should leave #{'$%.2f' % calc_tip_amount}.
The grand total for this meal is then #{'$%.2f' % calc_grand_total}."
      end

      protected

      def calc_meal_amount
        @calculator_vars.meal_amount + calc_tax_amount
      end

      def calc_tax_amount
        @calculator_vars.meal_amount * @calculator_vars.tax_percent / 100
      end

      def calc_tip_amount
        @calculator_vars.meal_amount * @calculator_vars.tip_percent / 100
      end

      def calc_grand_total
        calc_meal_amount + calc_tip_amount
      end
    end

  end
end