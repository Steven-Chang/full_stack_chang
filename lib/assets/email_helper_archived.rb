# frozen_string_literal: true

# lib/task_helpers/email_helper.rb

# require 'sendgrid-ruby'

# module EmailHelper
#   include SendGrid

#   def self.send_email(from_email, from_name, to_email, subject, html_string)
#     from = Email.new(email: from_email, name: from_name)
#     to = Email.new(email: to_email)
#     content = Content.new(type: 'text/html', value: html_string)
#     mail = SendGrid::Mail.new(from, subject, to, content)
#     mail.reply_to = Email.new(email: 'some_email@email.com')

#     sg = SendGrid::API.new(api_key: Rails.application.credentials.sendgrid[:api_key])
#     response = sg.client.mail._('send').post(request_body: mail.to_json)

#     Rails.logger.debug ''"
#       #{response.status_code}
#       #{response.body}
#       #{response.headers}
#     "''
#   end
# end
