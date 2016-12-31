class AttachmentsRemoveUrlNullFalse < ActiveRecord::Migration[5.2]
  def change
  	change_column :attachments, :url, :string, null: true
  end
end
