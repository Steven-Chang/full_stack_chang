# frozen_string_literal: true

# class WillJob < ApplicationJob
#   include SendGrid

#   after_perform do |_job|
#     WillJob.set(wait_until: Time.zone.now + 24.hours).perform_later unless WillJob.scheduled?
#   end

#   def perform
#     sender_email = 'sender@email.com'
#     beneficiaries = {
#       'Person One': {
#         email: 'person_one@email.com',
#         phone_number: '0400 000 001'
#       },
#       'Person Two': {
#         email: 'person_two@email.com',
#         phone_number: '0400 000 002'
#       },
#       'Person Three': {
#         email: 'person_three@email.com',
#         phone_number: '0400 000 003'
#       }
#     }
#     beneficiary_emails = []

#     return unless Rails.env.production?

#     if BlogPost.where('created_at > ?', Time.current - 30.days).present?
#       beneficiary_emails.push(sender_email) if Date.current.day == 1
#     else
#       beneficiaries.each do |_key, value|
#         beneficiary_emails.push(value[:email])
#       end
#     end

#     beneficiary_emails.each do |beneficiary_email|
#       mail = SendGrid::Mail.new
#       mail.from = Email.new(email: sender_email, name: 'Sender Name')
#       personalization = Personalization.new
#       personalization.add_to(Email.new(email: beneficiary_email))
#       # personalization.add_dynamic_template_data(dynamic_template_data)
#       mail.add_personalization(personalization)
#       mail.template_id = 'some-template-id'

#       sg = SendGrid::API.new(api_key: Rails.application.credentials.sendgrid[:api_key])
#       begin
#         sg.client.mail._('send').post(request_body: mail.to_json)
#       rescue StandardError => e
#         Rails.logger.debug e.message
#       end
#     end
#   end
# end
