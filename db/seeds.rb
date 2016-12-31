# frozen_string_literal: true

# === ADMIN ===
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development? && User.find_by(email: 'admin@example.com').nil?

# === EXCHANGES ===
puts 'Creating exchanges'
Exchange.create_default_exchanges
