class RemoveAwsColumnFromAttachments < ActiveRecord::Migration[6.0]
  def change
    remove_column :full_stack_chang_attachments, :aws_key
  end
end
