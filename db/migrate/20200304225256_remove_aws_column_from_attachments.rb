class RemoveAwsColumnFromAttachments < ActiveRecord::Migration[6.0]
  def change
    remove_column :attachments, :aws_key
  end
end
