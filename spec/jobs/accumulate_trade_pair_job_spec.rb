# frozen_string_literal: true
# https://relishapp.com/rspec/rspec-rails/docs/job-specs/job-spec

require 'rails_helper'

RSpec.describe AccumulateTradePairJob, type: :job do
  describe '#perform_later' do
    it 'performs AccumulateTradePairJob' do
      ActiveJob::Base.queue_adapter = :test
      expect { AccumulateTradePairJob.perform_later(1) }.to have_enqueued_job
    end
  end
end
