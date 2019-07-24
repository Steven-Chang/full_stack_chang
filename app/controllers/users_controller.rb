# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_admin_user!

  def index
    render json: User.all
  end

  def return_number_of_users
    number_of_users = User.all.count
    object_to_send_back = { number_of_users: number_of_users }

    respond_to do |format|
      format.json { render :json => object_to_send_back, status => 200 }
    end
  end
end
