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
    create_list(:project, number_of_public_projects, private: false)
    create_list(:project, number_of_private_projects, private: true)
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

        it 'returns private and public posts' do
          get :index, params: params
          returned_projects = JSON.parse(response.parsed_body)
          puts returned_projects
          expect(returned_projects.length).to eq(number_of_projects)
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
      end
    end
  end
end
