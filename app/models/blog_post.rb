# frozen_string_literal: true

class BlogPost < ApplicationRecord
	acts_as_taggable
	
  has_many :attachments, as: :resource, dependent: :destroy, inverse_of: :blog_post
end
