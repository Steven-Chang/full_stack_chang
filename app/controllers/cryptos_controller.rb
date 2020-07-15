# frozen_string_literal: true

class CryptosController < ApplicationController
  def index
    @cryptos = Crypto.all
  end
end
