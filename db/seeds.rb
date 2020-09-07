# frozen_string_literal: true

# === ADMIN ===
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# === PROJECTS ===
if Project.find_by(title: 'tetris').nil?
  puts 'Creating project Tetris'
  Project.create(
    title: 'tetris',
    private: false
  )

  puts 'Creating scores for Tetris'
  NUMBER_OF_SCORES = 5
  NUMBER_OF_SCORES.times do |n|
    Project.find_by(title: 'tetris')
           .scores
           .create(
             level: n,
             lines: n,
             score: n,
             name: 'stevenchang50000'
           )
  end
end

# === EXCHANGES ===
puts 'Creating exchanges'
Exchange.create_default_exchanges
