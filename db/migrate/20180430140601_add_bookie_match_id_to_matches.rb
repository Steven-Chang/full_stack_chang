class AddBookieMatchIdToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :bookie_match_id, :string
  end
end
