# frozen_string_literal: true

class TranxactionsController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
