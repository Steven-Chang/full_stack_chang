# frozen_string_literal: true

class ProjectSerializer < ActiveModel::Serializer
  attributes :id,
             :description,
             :private,
             :title,
             :url,
             :start_date,
             :end_date

  has_many :attachments

  def start_date
    @instance_options[:current_user]&.email == 'prime_pork@hotmail.com' ? object.start_date : nil
  end

  def end_date
    @instance_options[:current_user]&.email == 'prime_pork@hotmail.com' ? object.end_date : nil
  end
end
