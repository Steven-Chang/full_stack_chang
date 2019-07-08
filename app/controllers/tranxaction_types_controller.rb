class TranxactionTypesController < ApplicationController
  before_action :authenticate_admin_user!

  def index
    @tranxaction_types = TranxactionType.all

    render :json => @tranxaction_types
  end

  def create
    tranxaction_type = TranxactionType.new( tranxaction_type_params )
    if tranxaction_type.save
      render :json => tranxaction_type
    else
      render :json => tranxaction_type.errors
    end
  end

  private

  def tranxaction_type_params
    params.require(:tranxaction_type).permit(:description)
  end
end
