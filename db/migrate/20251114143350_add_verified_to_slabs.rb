class AddVerifiedToSlabs < ActiveRecord::Migration[8.0]
  def change
    add_column :slabs, :verified, :boolean
  end
end
