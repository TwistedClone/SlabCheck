class MakeSlabIdNullableInVerifications < ActiveRecord::Migration[8.0]
  def change
    change_column_null :verifications, :slab_id, true
  end
end
