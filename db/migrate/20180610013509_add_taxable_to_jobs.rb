class AddTaxableToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :taxable, :boolean, default: true
  end
end
