class ClientsReferenceUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :clients, :user, index: true
  end
end
