# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "This will not touch any users or projects..."
puts "Destroying all scores, levels and lines..."
Score.destroy_all

puts "Creating 5 scores, levels and lines for Tetris"
5.times do |number|
  score = Project.where(:title => "Tetris").first.scores.new
  score.score = number
  score.save

  level = Level.new
  level.level = number
  score.level = level

  line = Line.new
  line.lines = number
  score.line = line
end