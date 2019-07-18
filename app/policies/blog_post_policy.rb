# frozen_string_literal: true

class BlogPostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user&.admin?
        scope.all
      else
        scope.where(private: false)
      end
    end
  end
end
