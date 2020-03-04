class AchievementsProjectsForeignKey < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key "achievements", "projects", name: "achievements_project_id_fk"
  end
end
