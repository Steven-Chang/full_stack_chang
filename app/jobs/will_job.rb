# frozen_string_literal: true

class WillJob < ApplicationJob
  include SendGrid

  after_perform do |_job|
    WillJob.set(wait_until: Time.zone.now + 24.hours).perform_later unless WillJob.scheduled?
  end

  def perform
    beneficiaries = {
      'Emily Chen': {
        email: 'emilychentszyan@gmail.com',
        phone_number: '0452 623 866'
      },
      'Chris Asnins': {
        email: 'asnins@live.com.au',
        phone_number: '0450 677 138'
      },
      'Steven Chang': {
        email: 'stevenchang5000@gmail.com',
        phone_number: '0405 818 525'
      }
    }
    beneficiary_emails = []

    return unless Rails.env.production?

    if BlogPost.where('created_at > ?', Time.current - 30.days).present?
      beneficiary_emails.push('stevenchang5000@gmail.com') if Date.current.day == 1
    else
      beneficiaries.each do |_key, value|
        beneficiary_emails.push(value[:email])
      end
    end

    beneficiary_emails.each do |beneficiary_email|
      mail = SendGrid::Mail.new
      mail.from = Email.new(email: 'stevenchang5000@gmail.com', name: 'Steven Chang')
      personalization = Personalization.new
      personalization.add_to(Email.new(email: beneficiary_email))
      # personalization.add_dynamic_template_data(dynamic_template_data)
      mail.add_personalization(personalization)
      mail.template_id = 'd-84b29bcd9de54ca7aaa6446e7cf646ad'

      sg = SendGrid::API.new(api_key: Rails.application.credentials.sendgrid[:api_key])
      begin
        sg.client.mail._('send').post(request_body: mail.to_json)
      rescue StandardError => e
        Rails.logger.debug e.message
      end
    end
  end
end
