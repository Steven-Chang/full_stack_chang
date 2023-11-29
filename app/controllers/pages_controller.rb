# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @page_title = 'Home'
  end

  def tax_summaries
    @page_title = 'Tax Summaries'
  end
end
