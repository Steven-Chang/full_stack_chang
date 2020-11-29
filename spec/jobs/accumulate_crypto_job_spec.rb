# frozen_string_literal: true

# https://relishapp.com/rspec/rspec-rails/docs/job-specs/job-spec

require 'rails_helper'

RSpec.describe AccumulateCryptoJob, type: :job do
  describe '#perform_later' do
    it 'runs AccumulateCryptoJob' do
      ActiveJob::Base.queue_adapter = :test
      expect { AccumulateCryptoJob.perform_later }.to have_enqueued_job
    end
  end

  describe '#perform' do
    it 'calls Credential.trade' do
      ActiveJob::Base.queue_adapter = :test
      expect(Credential).to receive(:trade)
      AccumulateCryptoJob.perform_now
    end
  end
end
