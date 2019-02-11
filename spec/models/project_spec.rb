# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:per_page) { 12 }
  let(:number_of_public_posts) { per_page / 2 }
  let(:number_of_private_posts) { per_page / 2 }
  let(:prime_pork_user) { create(:user, email: 'prime_pork@hotmail.com') }
  let(:user) { create(:user) }
  let(:project) { create(:project) }

  describe 'attributes' do
    before do
      @title = 'Title'
      @project = create(:project, title: @title)
    end

    it 'should have a title attribute' do
      expect(@project.title).to eq(@title)
    end

    it 'should have a private attribute which defaults to true' do
      expect(@project.private).to eq(true)
    end
  end
end
