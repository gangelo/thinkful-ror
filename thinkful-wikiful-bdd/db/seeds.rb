# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create 8 seed categories
categories = Category.create([
  { name: 'History' },
  { name: 'Biology' },
  { name: 'Literature' },
  { name: 'Mathematics' },
  { name: 'Music Theory' },
  { name: 'Computer Science' },
  { name: 'Sociology' },
  { name: 'Chemistry' },
  { name: 'Cake and Pie' }
])