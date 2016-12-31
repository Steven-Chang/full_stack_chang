class AddAwsKeyToAttachments < ActiveRecord::Migration[5.1]
  def change
    add_column :attachments, :aws_key, :string
  end
end
