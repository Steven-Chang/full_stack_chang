class AttachmentsRemoveUrlNullFalse < ActiveRecord::Migration[5.2]
  def change
  	change_column :full_stack_chang_attachments, :url, :string, null: true
  end
end
