class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string :resource_type, null: false
      t.integer :resource_id, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
