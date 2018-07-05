class TenancyAgreement < ApplicationRecord
  belongs_to :user
  belongs_to :property
end
