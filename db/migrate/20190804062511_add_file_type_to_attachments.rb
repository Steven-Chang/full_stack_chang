class AddFileTypeToAttachments < ActiveRecord::Migration[5.2]
  def change
  	add_column :full_stack_chang_attachments, :file_type, :integer, default: 1
  end
end
