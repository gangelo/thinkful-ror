#!/usr/bin/env ruby

module Thinkful
  module TipCalculator

    VERSION = '0.0.1'
  end
end

require_relative 'calculator'
require_relative 'calculator_vars'
require_relative 'calculator_result'

print 'Enter the meal amount: '
meal_amount = gets.chomp.to_f

print 'Enter the tax %: '
tax_percent = gets.chomp.to_f

print 'Enter the tip %: '
tip_percent = gets.chomp.to_f

calculator_vars = Thinkful::TipCalculator::CalculatorVars.new meal_amount, tax_percent, tip_percent

calculator = Thinkful::TipCalculator::Calculator.new calculator_vars

calculator_result = calculator.calculate

#puts 'Meal amount: ' + calculator_result.meal_amount.to_s
#puts 'Tip amount: ' + calculator_result.tip_amount.to_s
#puts 'Grand total: ' +calculator_result.grand_total.to_s   

puts calculator.print_string 
