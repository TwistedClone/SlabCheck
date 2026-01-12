class AddPopulationFieldsToSlabs < ActiveRecord::Migration[8.0]
  def change
    add_column :slabs, :population_total, :integer
    add_column :slabs, :population_higher, :integer
    add_column :slabs, :population_percentage, :float
  end
end
