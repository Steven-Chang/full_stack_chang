class CreateTranxactionSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :tranxaction_schedules do |t|
    	t.decimal :amount, precision: 8, scale: 2, default: '0.0', null: false
      t.references :creditor, index: true
    	t.date :date, null: false
      t.integer :days_for_recurrence
    	t.string :description, null: false
      t.boolean :enabled
    	t.boolean :tax
    	t.references :tax_category
      t.references :tranxactable, null: false, polymorphic: true, index: { name: 'index_tranxaction_schedules_on_tranxactable' }

      t.timestamps
    end
  end
end
