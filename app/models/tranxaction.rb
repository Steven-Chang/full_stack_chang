class Tranxaction < ApplicationRecord
  has_many :tranxactables
  has_many :attachments, as: :resource, dependent: :destroy

  after_create do |tranxaction|
    tranxaction.tranxactables.each do |tranxactable|
      if tranxactable.resource_type == "Client"
        # We want to build the work tranxactable
        new_tranxactable = Tranxactable.new
        new_tranxactable.resource_type = "TranxactionType"
        new_tranxactable.resource_id = TranxactionType.find_by(description: "work").id
        new_tranxactable.tranxaction_id = tranxaction.id
        new_tranxactable.save
      end
    end
  end
end
