class AddFileTypeToAttachments < ActiveRecord::Migration[5.2]
  def change
  	add_column :attachments, :file_type, :integer, default: 1
  end
end
