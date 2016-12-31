class AddCloudinaryPublicIdToAttachments < ActiveRecord::Migration[5.2]
  def change
  	add_column :attachments, :cloudinary_public_id, :string, index: { unique: true }
  end
end
