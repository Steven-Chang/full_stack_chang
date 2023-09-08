class ActiveAdminCommentsRestoreTableName < ActiveRecord::Migration[6.0]
  def change
    rename_index :fsc_active_admin_comments, 'fsc_ind_active_admin_comments_on_author_type_and_author_id', 'index_active_admin_comments_on_author_type_and_author_id'
    rename_index :fsc_active_admin_comments, 'fsc_ind_active_admin_comments_on_namespace', 'index_active_admin_comments_on_namespace'
    rename_index :fsc_active_admin_comments, 'fsc_ind_active_admin_comments_on_resource_type_and_resource_id', 'index_active_admin_comments_on_resource_type_and_resource_id'

    rename_table :fsc_active_admin_comments, :active_admin_comments
  end
end
