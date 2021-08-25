class CreateFileImports < ActiveRecord::Migration[6.1]
  def change
    create_table :file_imports do |t|
      t.integer :report_id, unique: true, null: false

      t.timestamps
    end
  end
end
