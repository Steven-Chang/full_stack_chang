class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.integer :tranxaction_id, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
