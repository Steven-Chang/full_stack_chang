# frozen_string_literal: true

class BlogPost < ApplicationRecord
  has_many :attachments, as: :resource, dependent: :destroy, inverse_of: :blog_post
end
