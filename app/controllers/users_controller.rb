class UsersController < ApplicationController

  def index
    respond_to do |format|
      format.json { render :json => User.all, status => 200 }
    end
  end

  def return_number_of_users
    number_of_users = User.all.count
    object_to_send_back = { number_of_users: number_of_users }

    respond_to do |format|
      format.json { render :json => object_to_send_back, status => 200 }
    end
  end

end
