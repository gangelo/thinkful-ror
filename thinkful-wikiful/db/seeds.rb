# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Load up some colors.
label_colors = [
	LabelColor.create(background_color: '#dd0000', color: '#fff'),
	LabelColor.create(background_color: '#00dd00', color: '#fff'),
	LabelColor.create(background_color: '#0000dd', color: '#fff'),
	LabelColor.create(background_color: '#660000', color: '#fff'),
	LabelColor.create(background_color: '#006600', color: '#fff'),
	LabelColor.create(background_color: '#000066', color: '#fff'),
	LabelColor.create(background_color: '#000', color: '#fff'),
	LabelColor.create(background_color: '#ccc', color: '#fff'),
	LabelColor.create(background_color: '#db9900', color: '#fff')
]

# Create 8 seed categories
categories = Category.create([
	{ name: 'History', 			label_color: label_colors[0] },
	{ name: 'Biology', 			label_color: label_colors[1] },
	{ name: 'Literature', 	label_color: label_colors[2] },
	{ name: 'Mathematics', 	label_color: label_colors[3] },
	{ name: 'Music Theory', label_color: label_colors[4] },
	{ name: 'Computer Science', label_color: label_colors[5] },
	{ name: 'Sociology', 				label_color: label_colors[6] },
	{ name: 'Chemistry', 				label_color: label_colors[7] },
	{ name: 'Cake and Pie', 		label_color: label_colors[8] }
])

# create 50 articles, with random titles, 250 words of content, and
# randomly assign one of the categories above to each article
for i in 0..49
	title = Faker::Lorem.sentence(rand(2..10)).chomp('.')
	content = Faker::Lorem.paragraph(word_count=250)

	# Randomly assign one of the categories we just created.
  # The 'sample' method selects a random item from a collection.
	category = Category.all.sample
	a = Article.create(title: title, content: content, categories: [category,])
end
