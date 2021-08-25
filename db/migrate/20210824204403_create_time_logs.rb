class CreateTimeLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :time_logs do |t|
      t.integer :employee_id, null: false
      t.date :date, null: false
      t.decimal :hours_worked, null: false
      t.string :job_group, null: false

      t.references :report, index: true, references: :file_imports, null: false, column: :report_id,
                            primary_key: :report_id
      t.monetize :wage, null: false

      t.timestamps
    end
  end
end
