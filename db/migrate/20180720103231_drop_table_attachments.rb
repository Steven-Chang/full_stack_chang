class DropTableAttachments < ActiveRecord::Migration[5.1]
  def change
    drop_table :attachments
  end
end
