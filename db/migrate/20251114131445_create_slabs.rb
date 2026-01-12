class CreateSlabs < ActiveRecord::Migration[8.0]
  def change
    create_table :slabs do |t|
      t.references :grading_company, null: false, foreign_key: true
      t.string :cert_number
      t.string :card_name
      t.string :grade
      t.jsonb :extra_data

      t.timestamps
    end
    add_index :slabs, :cert_number
  end
end
