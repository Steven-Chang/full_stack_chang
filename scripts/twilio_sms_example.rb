# frozen_string_literal: true

@client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']

@client.region = 'au1'

@client.messages.create(
  from: '+12054152599',
  to: '+61405818525',
  body: 'Hey there!'
)

# Sent from your Twilio trial account - Hey there!
