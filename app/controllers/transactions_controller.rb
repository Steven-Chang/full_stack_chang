class GamblingTransactionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :authenticate_admin

  def index
    respond_to do |format|
      format.json { render :json => current_user.transactions, :status => 200 }
    end
  end

  def create


    redirect_to :action => "index", title: Project.find(@project_id).title, format: :json
  end

  private

  def authenticate_admin
    redirect_to root_path unless current_user && current_user.admin
  end
end
