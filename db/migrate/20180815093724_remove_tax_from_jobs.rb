class RemoveTaxFromJobs < ActiveRecord::Migration[5.1]
  def change
    remove_column :jobs, :taxable, :boolean
  end
end
