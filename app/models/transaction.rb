class Transaction < ApplicationRecord
  belongs_to :transaction_type
  belongs_to :resource,
             :polymorphic => true,
             :optional => true

end
