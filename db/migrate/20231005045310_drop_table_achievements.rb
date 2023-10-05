class DropTableAchievements < ActiveRecord::Migration[7.0]
  def change
    drop_table :achievements
  end
end
