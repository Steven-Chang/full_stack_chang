# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.table_name_prefix
    'fsc_'
  end
end
