# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Credential, type: :model do
  let(:trade_pair) { create(:trade_pair) }

  describe 'ASSOCIATIONS' do
    it { should belong_to :exchange }
    it { should have_many(:trade_pairs).dependent(:restrict_with_exception) }
    it { should have_many(:orders).through(:trade_pairs) }
  end

  describe 'CLASS METHODS' do
    describe '.trade' do
      context 'when credential is enabled' do
        before { trade_pair.credential.update!(enabled: true) }

        context 'when trade_pair is enabled' do
          before do
            trade_pair.update!(enabled: true)
          end

          it 'calls AccumulateTradePairJob with the trade pair id' do
            expect(AccumulateTradePairJob).to receive(:perform_later).with(trade_pair.id)
            Credential.trade
          end
        end

        context 'when trade_pair is not enabled' do
          before do
            trade_pair.update!(enabled: false)
          end

          it 'does not call #accumulate on the order' do
            expect(AccumulateTradePairJob).not_to receive(:perform_later).with(trade_pair.id)
            Credential.trade
          end
        end
      end

      context 'when credential is disabled' do
        before { trade_pair.credential.update!(enabled: false) }

        context 'when trade_pair is enabled' do
          before do
            trade_pair.update!(enabled: true)
          end

          it 'does not call AccumulateTradePairJob with the trade pair id' do
            expect(AccumulateTradePairJob).not_to receive(:perform_later).with(trade_pair.id)
            Credential.trade
          end
        end
      end
    end
  end
end
