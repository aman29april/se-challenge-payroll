require 'csv'

class ImportCsv
  attr_reader :error

  def initialize(file)
    @file = file
    @csv = CSV.parse(file.read, headers: true)
    debugger
    validate
  end

  def import
    return if @error.present?
    ActiveRecord::Base.transaction do
      file_import = FileImport.create!(report_id: report_id_from_filename)
      @csv.each do  |row|
        file_import.time_logs.build({
                                      date: row[0],
                                      hours_worked: row[1],
                                      employee_id: row[2],
                                      job_group: row[3],
                                      wage: TimeLog.group_rates[row[3]]
                                    })
      end
      file_import.save!

    end
  rescue ActiveRecord::RecordInvalid => exception
    fail!(exception.message)
  end

  def validate
    fail!('Invald File') if @file.content_type != 'text/csv'
  end

  def success?
    @error.nil?
  end

  private
  def fail!(error)
    @error = error
  end

  def report_id_from_filename
    File.basename(@file.original_filename, ".*").split('-').last.to_i
  end

end
