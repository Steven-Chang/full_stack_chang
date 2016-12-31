class AddOffsetDateToScheduledTranxactionTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :scheduled_tranxaction_templates, :date_offset, :integer, default: 0
  end
end
