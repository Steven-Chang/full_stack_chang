# frozen_string_literal: true

# === ADMIN ===
if Rails.env.development? && User.find_by(email: 'admin@example.com').nil?
  User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

# === EXCHANGES ===
puts 'Creating exchanges'
Exchange.create_default_exchanges
