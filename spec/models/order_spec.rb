# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build(:order) }

  describe 'ASSOCIATIONS' do
    it { should belong_to(:trade_pair) }
    it { should have_one(:exchange).through(:trade_pair) }
  end

  describe 'VALIDATIONS' do
    it { should validate_inclusion_of(:buy_or_sell).in_array(%w[buy sell]) }
    it { should validate_inclusion_of(:status).in_array(%w[open filled]) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:buy_or_sell) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:quantity) }
  end

  describe 'DELEGATES' do
    it { should delegate_method(:client).to(:exchange) }
    it { should delegate_method(:symbol).to(:trade_pair) }
  end

  describe 'CALLBACKS' do
    describe 'before_validation' do
      context 'when buy_or_sell is present' do
        it 'downcases buy_or_sell' do
          order.buy_or_sell = 'BUY'
          order.save
          expect(order.buy_or_sell).to eq 'buy'
        end
      end

      context 'when status is present' do
        it 'changes new to open' do
          order.status = 'NEW'
          order.save
          expect(order.status).to eq 'open'
        end

        it 'downcases the status' do
          order.status = 'FILLED'
          order.save
          expect(order.status).to eq 'filled'
        end
      end
    end
  end
end
