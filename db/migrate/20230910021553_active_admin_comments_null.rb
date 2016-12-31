class ActiveAdminCommentsNull < ActiveRecord::Migration[7.0]
  def change
    change_column :active_admin_comments, :namespace, :string, null: false
    change_column :active_admin_comments, :body, :text, null: false
    change_column :active_admin_comments, :resource_type, :string, null: false
    change_column :active_admin_comments, :resource_id, :bigint, null: false
    change_column :active_admin_comments, :author_type, :string, null: false
    change_column :active_admin_comments, :author_id, :bigint, null: false
  end
end
