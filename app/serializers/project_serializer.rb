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
    @instance_options[:current_user]&.the_boss_man? ? object.start_date : nil
  end

  def end_date
    @instance_options[:current_user]&.the_boss_man? ? object.end_date : nil
  end
end
