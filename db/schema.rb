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

ActiveRecord::Schema.define(version: 20_210_824_204_403) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'file_imports', id: false, force: :cascade do |t|
    t.integer 'report_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'time_logs', force: :cascade do |t|
    t.integer 'employee_id', null: false
    t.date 'date', null: false
    t.decimal 'hours_worked', null: false
    t.string 'job_group', null: false
    t.bigserial 'report_id', null: false
    t.integer 'wage_cents', default: 0, null: false
    t.string 'wage_currency', default: 'CAD', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['report_id'], name: 'index_time_logs_on_report_id'
  end
end
