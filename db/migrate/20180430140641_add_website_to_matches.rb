class AddWebsiteToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :website, :string
  end
end
