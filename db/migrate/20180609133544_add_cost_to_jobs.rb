class AddCostToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :cost, :decimal, precision: 18, scale: 8, default: 0
  end
end
