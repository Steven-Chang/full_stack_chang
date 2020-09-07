# frozen_string_literal: true

# === ADMIN ===
if Rails.env.development? && User.find_by(email: 'admin@example.com').nil?
  User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') 
end

# === PROJECTS ===
if Project.find_by(title: 'tetris').nil?
  puts 'Creating project Tetris'
  Project.create!(
    title: 'tetris',
    private: false,
    start_date: Date.current
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
