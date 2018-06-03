class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :client_id, null: false
      t.integer :user_id, null: false
      t.datetime :start_time
      t.datetime :end_time
      t.text :description, null: false

      t.timestamps null: false
    end
  end
end
