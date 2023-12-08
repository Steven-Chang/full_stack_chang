# frozen_string_literal: true

# https://activeadmin.info/3-index-pages/index-as-table.html 
module AdminDisplayable
  extend ActiveSupport::Concern
  
  def display_name
    "#{user_name}: #{name}"
  end
end
