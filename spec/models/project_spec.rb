# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { build(:project) }

  describe 'ASSOCIATIONS' do
    it { should have_many(:scores).dependent(:destroy) }
    it { should have_many(:attachments).dependent(:destroy) }
  end

  describe 'VALIDATIONS' do
    it { should validate_presence_of(:title) }
  end

  describe 'INSTANCE METHODS' do
    describe '#duration_formatted' do
      context 'when project has no start_date' do
        it 'returns nil' do
          project.start_date = nil
          expect(project.duration_formatted).to be nil
        end
      end

      context 'when project has a start_date' do
        context 'when project does not have an end date' do
          it 'sets the duration using the current date' do
            project.end_date = nil
            project.start_date = Date.current - 1.day
            expect(project.duration_formatted).to eq('1 day')
            project.start_date = Date.current - 31.days
            expect(project.duration_formatted).to eq('1 month 1 day')
            project.start_date = Date.current - 792.days
            expect(project.duration_formatted).to eq('2 years 2 months 2 days')
          end
        end

        context 'when project has an end date' do
          it 'sets the duration using the end date' do
            project.end_date = Date.current - 1.day
            project.start_date = project.end_date - 1.day
            expect(project.duration_formatted).to eq('1 day')
            project.start_date = project.end_date - 31.days
            expect(project.duration_formatted).to eq('1 month 1 day')
            project.start_date = project.end_date - 427.days
            expect(project.duration_formatted).to eq('1 year 2 months 2 days')
          end
        end
      end
    end
  end
end
