require 'csv'

class ImportCsv
  attr_reader :error

  def initialize(file)
    @file = file
    @csv = CSV.parse(file.read, headers: true)
  end

  def call
    return if @error.present?

    ActiveRecord::Base.transaction do
      file_import = FileImport.create!(report_id: report_id_from_filename)
      @csv.each do  |row|
        file_import.time_logs.build(time_log_attributes(row))
      end
      file_import.save!
    end
  rescue ActiveRecord::RecordInvalid => e
    fail!(e.message)
  end

  def success?
    @error.nil?
  end

  private

  def time_log_attributes(row)
    hours_worked = row['hours worked'].to_f
    {
      date: row['date'],
      hours_worked: hours_worked,
      employee_id: row['employee id'],
      job_group: row['job group'],
      wage: (TimeLog.group_rates[row['job group'].to_sym] * hours_worked).to_money
    }
  end

  def fail!(error)
    @error = error
  end

  def report_id_from_filename
    File.basename(@file.original_filename, '.*').split('-').last.to_i
  end
end
