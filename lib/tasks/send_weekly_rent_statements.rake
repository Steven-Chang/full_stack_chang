namespace :fsc do
  desc "Weekly emailing of rental statement"
  task :send_rent_statement => :environment do

    require 'sendgrid-ruby'
    include SendGrid


from = Email.new(email: 'prime_pork@hotmail.com')
to = Email.new(email: 'admin@livefinder.com')
subject = 'Sending with SendGrid is Fun'
content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = SendGrid::Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers

  end
end