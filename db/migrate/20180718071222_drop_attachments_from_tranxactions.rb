class DropAttachmentsFromTranxactions < ActiveRecord::Migration[5.1]
  def change
    remove_column :tranxactions, :attachments, :string
  end
end
