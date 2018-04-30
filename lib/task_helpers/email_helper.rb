require 'sendgrid-ruby'

module EmailHelper
  include SendGrid

  def self.send_email( from_email, from_name, to_email, subject, html_string )
    from = Email.new(email: from_email, name: from_name)
    to = Email.new(email: to_email)
    content = Content.new(type: 'text/html', value: html_string)
    mail = SendGrid::Mail.new(from, subject, to, content)
    mail.reply_to = Email.new(email: 'prime_pork@hotmail.com')

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)

    puts response.status_code
    puts response.body
    puts response.headers
  end
end