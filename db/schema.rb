# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_11_14_144050) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "grading_companies", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slabs", force: :cascade do |t|
    t.bigint "grading_company_id", null: false
    t.string "cert_number"
    t.string "card_name"
    t.string "grade"
    t.jsonb "extra_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "verified"
    t.integer "population_total"
    t.integer "population_higher"
    t.float "population_percentage"
    t.index ["cert_number"], name: "index_slabs_on_cert_number"
    t.index ["grading_company_id"], name: "index_slabs_on_grading_company_id"
  end

  create_table "verifications", force: :cascade do |t|
    t.bigint "slab_id"
    t.jsonb "raw_response"
    t.boolean "success"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slab_id"], name: "index_verifications_on_slab_id"
  end

  add_foreign_key "slabs", "grading_companies"
  add_foreign_key "verifications", "slabs"
end
