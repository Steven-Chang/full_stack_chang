class UsersController < ApplicationController

  def index
    render :json => User.all
  end

  def return_number_of_users
    number_of_users = User.all.count
    object_to_send_back = { number_of_users: number_of_users }

    respond_to do |format|
      format.json { render :json => object_to_send_back, status => 200 }
    end
  end

  def update_other_params
    user_id = params[:user_id]
    user = User.find(user_id)
    user.tenant = params[:tenant]
    user.admin = params[:admin]
    user.save

    respond_to do |format|
      format.json {
        render :json => user,
        status => 200
      }
    end
  end

end
