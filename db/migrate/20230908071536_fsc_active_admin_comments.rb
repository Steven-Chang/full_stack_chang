class FscActiveAdminComments < ActiveRecord::Migration[6.0]
  def change
    rename_index :active_admin_comments, 'index_active_admin_comments_on_author_type_and_author_id', 'fsc_i_active_admin_comments_on_author_type_and_author_id'
    rename_index :active_admin_comments, 'index_active_admin_comments_on_namespace', 'fsc_i_active_admin_comments_on_namespace'
    rename_index :active_admin_comments, 'index_active_admin_comments_on_resource_type_and_resource_id', 'fsc_i_active_admin_comments_on_resource_type_and_resource_id'

    rename_table :active_admin_comments, :fsc_active_admin_comments
  end
end
