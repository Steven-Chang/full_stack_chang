class UpdateIdTypeToBigintWhereRecommended < ActiveRecord::Migration[7.0]
  def change
    change_column :blog_posts, :id, :bigint
    change_column :clients, :id, :bigint
    change_column :projects, :id, :bigint
    change_column :users, :id, :bigint
  end
end
