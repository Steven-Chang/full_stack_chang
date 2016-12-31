class AddDescriptionToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :description, :string
  end
end
