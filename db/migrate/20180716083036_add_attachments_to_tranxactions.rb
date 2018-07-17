class AddAttachmentsToTranxactions < ActiveRecord::Migration[5.1]
  def change
    add_column :tranxactions, :attachments, :string
  end
end
