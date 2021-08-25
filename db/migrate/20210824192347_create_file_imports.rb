class CreateFileImports < ActiveRecord::Migration[6.1]
  def change
    create_table :file_imports, id: false, primary_key: :report_id do |t|
      t.integer :report_id, unique: true

      t.timestamps
    end
  end
end
