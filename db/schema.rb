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

ActiveRecord::Schema.define(version: 2021_08_24_204403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "file_imports", force: :cascade do |t|
    t.integer "report_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "time_logs", force: :cascade do |t|
    t.integer "employee_id", null: false
    t.date "date", null: false
    t.decimal "hours_worked", null: false
    t.string "job_group", null: false
    t.bigint "file_import_id"
    t.integer "wage_cents", default: 0, null: false
    t.string "wage_currency", default: "CAD", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["file_import_id"], name: "index_time_logs_on_file_import_id"
  end

  add_foreign_key "time_logs", "file_imports"
end
