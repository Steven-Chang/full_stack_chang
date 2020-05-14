class AddVisibleToTools < ActiveRecord::Migration[6.0]
  def change
    add_column :tools, :visible, :boolean
  end
end
