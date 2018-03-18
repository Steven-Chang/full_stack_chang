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

  def tenants
    tenants = User.where(:tenant => true)

    respond_to do |format|
      format.json { render :json => tenants.to_json({:methods => [:password]}), status => 200 }
    end
  end

  def bond
    user_id = params[:user_id]
    puts user_id
    bond = RentTransaction.get_bond_for_user( user_id )

    respond_to do |format|
      format.json {
        render :json => { bond: bond },
        status => 200
      }
    end
  end

  def balance
    user_id = params[:user_id]
    balance = RentTransaction.get_balance_for_user( user_id )

    respond_to do |format|
      format.json {
        render :json => { balance: balance },
        status => 200
      }
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
