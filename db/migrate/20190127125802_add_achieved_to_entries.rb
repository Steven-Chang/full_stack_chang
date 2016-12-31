class AddAchievedToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :achieved, :boolean, default: false
  end
end
