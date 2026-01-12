class CreateVerifications < ActiveRecord::Migration[8.0]
  def change
    create_table :verifications do |t|
      t.references :slab, null: false, foreign_key: true
      t.jsonb :raw_response
      t.boolean :success

      t.timestamps
    end
  end
end
