class AddAwsKeyToAttachments < ActiveRecord::Migration[5.1]
  def change
    add_column :full_stack_chang_attachments, :aws_key, :string
  end
end
