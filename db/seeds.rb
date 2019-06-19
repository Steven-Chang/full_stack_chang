# frozen_string_literal: true

return unless Rails.env.development?

puts 'Creating project Tetris'
Project.find_or_create_by(
  title: 'tetris',
  private: false
)

puts 'Destroying all scores, levels and lines...'
Score.destroy_all

puts 'Creating scores for Tetris'
NUMBER_OF_SCORES = 5
NUMBER_OF_SCORES.times do |n|
  score = Project.find_by(title: 'tetris').scores.create(
    score: n,
    name: 'Chubb'
  )
  level = Level.create(
    level: n,
    score: score
  )
  line = Line.create(
    lines: n,
    score: score
  )
  score.update!(
    level: level,
    line: line
  )
end
