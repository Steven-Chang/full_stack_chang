# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:per_page) { 12 }
  let(:number_of_public_projects) { per_page / 2 }
  let(:number_of_private_projects) { per_page / 2 }
  let(:number_of_projects) do
    number_of_private_projects + number_of_public_projects
  end
  let(:prime_pork_user) { create(:user, email: 'prime_pork@hotmail.com') }
  let(:user) { create(:user) }
  before do
    create_list(:project,
                number_of_public_projects,
                private: false, start_date: Time.zone.today,
                end_date: Time.zone.today)
    create_list(:project,
                number_of_private_projects,
                private: true, start_date: Time.zone.today,
                end_date: Time.zone.today)
  end

  describe '#index' do
    context 'JSON' do
      let(:params) do
        { format: 'json' }
      end
      context 'when prime_pork@hotmail.com user is signed in' do
        before do
          allow(controller).to receive(:current_user) { prime_pork_user }
        end

        it 'returns private and public projects' do
          get :index, params: params
          returned_projects = JSON.parse(response.parsed_body)
          expect(returned_projects.length).to eq(number_of_projects)
        end

        it 'returns the start and end dates for projects' do
          get :index, params: params
          returned_projects = JSON.parse(response.parsed_body)
          returned_project = returned_projects[0]
          returned_start_date = Date.parse(returned_project['start_date'])
          returned_end_date = Date.parse(returned_project['end_date'])
          expect(returned_start_date).to eq(Time.zone.today)
          expect(returned_end_date).to eq(Time.zone.today)
        end
      end

      context 'when a user that is not prime_pork@hotmail.com is signed in' do
        before do
          allow(controller).to receive(:current_user) { user }
        end

        it 'only return public blog posts' do
          get :index, params: params
          returned_projects = JSON.parse(response.parsed_body)
          expect(returned_projects.length).to eq(number_of_public_projects)
          returned_projects.each do |project|
            expect(project['private']).to eq(false)
          end
        end

        it 'does not return the start or end date' do
          get :index, params: params
          returned_projects = JSON.parse(response.parsed_body)
          returned_project = returned_projects[0]
          expect(returned_project['start_date']).to be nil
          expect(returned_project['end_date']).to be nil
        end
      end

      context 'when a user is not signed in' do
        before do
          allow(controller).to receive(:current_user) { nil }
        end

        it 'only return public blog posts' do
          get :index, params: params
          returned_projects = JSON.parse(response.parsed_body)
          expect(returned_projects.length).to eq(number_of_public_projects)
          returned_projects.each do |project|
            expect(project['private']).to eq(false)
          end
        end

        it 'does not return the start or end date' do
          get :index, params: params
          returned_projects = JSON.parse(response.parsed_body)
          returned_project = returned_projects[0]
          expect(returned_project['start_date']).to be nil
          expect(returned_project['end_date']).to be nil
        end
      end
    end
  end
end
