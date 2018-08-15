class RemoveUserIdFromJobs < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :user_id, :integer
  end
end
