class CreateGradingCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :grading_companies do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
