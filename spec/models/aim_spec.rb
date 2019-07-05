# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Aim, type: :model do
  let(:aim) { build(:aim) }

  describe 'ASSOCIATIONS' do
    it { should have_many(:entries).dependent(:destroy) }
  end

  describe 'CALLBACKS' do
    describe 'after_create' do
      it 'calls #create_initial_entries' do
        expect(aim).to receive(:create_initial_entries)
        aim.save!
      end
    end
  end

  describe 'INSTANCE METHODS' do
    describe '#create_initial_entries' do
      context 'when there are no entries' do
        it 'creates an entry for the aim for the current day only' do
          aim.save!
          expect(aim.entries.count).to be 1
          expect(aim.entries.first.date).to eq(Date.current)
        end
      end

      context 'where there are entries' do
        before do
          aim_two = create(:aim)
          aim_two.entries.create(date: Date.current - 1.day)
        end

        it 'creates an entry for the aim from the earliest existing entry to the latest' do
          aim.save!
          expect(aim.entries.count).to be 2
          expect(aim.entries.order(:date).first.date).to eq(Date.current - 1.day)
          expect(aim.entries.order(:date).last.date).to eq(Date.current)
        end
      end
    end
  end
end
