# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BlogPostsController, type: :controller do

  let(:number_of_posts){ 10 }
  let(:user){ create(:userx) }

  describe '#index' do
    context 'JSON' do
      let(:params){
        { :format => 'json' }
      }

      # context 'baddie_user_id has not been sent up' do
      #   it 'returns a response not found' do
      #     get :index, params: params
      #     expect(response.not_found?).to eq(true)
      #   end
      # end

      # context 'baddie_user_id has been sent up' do
      #   context 'baddie_user_id is valid' do
      #     before(:each){
      #       params["baddie_user_id"] = @baddie_user.id
      #     }

      #     it 'does not returns a response not found' do
      #       get :index, params: params
      #       expect(response.not_found?).to eq(false)
      #     end

      #     context "Baddie has the subscription option for feed" do
      #       context 'The subscription option feed is active' do
      #         before(:each) do
      #           subscription_option = @baddie_user.subscription_options.find_by(subscription_type_id: @subscription_type_feed.id)
      #           subscription_option.active = true
      #           subscription_option.save
      #         end

      #         it "returns an array of the two baddie's posts descending by updated_at" do
      #           get :index, params: params
      #           expect(JSON.parse(response.parsed_body).length).to eq(@baddie_user.posts.order('updated_at DESC').length)
      #         end
      #       end

      #       context 'The subscription option feed is inactive' do
      #         before(:each) do
      #           subscription_option = @baddie_user.subscription_options.find_by(subscription_type_id: @subscription_type_feed.id)
      #           subscription_option.active = false
      #           subscription_option.save!
      #         end

      #         context "user is signed in" do
      #           before do
      #             allow(controller).to receive(:current_user) { @user }
      #           end

      #           context "user has an active feed subscription to this baddie" do
      #             before(:each) do
      #               @user.subscriptions.create(
      #                 baddie_user_id: @baddie_user.id,
      #                 amount: 123,
      #                 subscription_type_id: @subscription_type_feed.id
      #               )
      #             end

      #             it 'returns posts' do
      #               get :index, params: params
      #               expect(JSON.parse(response.parsed_body).length).to_not eq(0)
      #             end

      #             context "user has an inactive feed subscription to this baddie" do
      #               before(:each) do
      #                 subscription = @user.subscriptions.first
      #                 subscription.is_active = false
      #                 subscription.save
      #               end

      #               it 'does not returns posts' do
      #                 get :index, params: params
      #                 expect(JSON.parse(response.parsed_body).length).to eq(0)
      #               end
      #             end
      #           end
      #         end

      #         context "user is not signed in" do
      #           it "returns an empty array" do
      #             get :index, params: params
      #             expect(JSON.parse(response.parsed_body).length).to eq(0)
      #           end
      #         end
      #       end
      #     end
      #   end

      #   context 'baddie_user_id is not valid' do
      #     before(:each){
      #       params["baddie_user_id"] = @baddie_user.id + 1
      #     }

      #     it 'returns a response not found' do
      #       get :index, params: params
      #       expect(response.not_found?).to eq(true)
      #     end
      #   end
      # end
    end
  end
end