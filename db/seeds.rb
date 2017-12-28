# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "This will not touch any users or projects..."
puts "This should be run after making the Tetris project and any other games that have scores..."
puts "Destroying all scores, levels and lines..."
Score.destroy_all

puts "Creating 5 scores, names, levels and lines for Tetris"
5.times do |number|
  score = Project.where(:title => "Tetris").first.scores.new
  score.score = number
  score.name = "Chubb"
  score.save

  level = Level.new
  level.level = number
  score.level = level

  line = Line.new
  line.lines = number
  score.line = line
end