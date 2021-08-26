class Api::FileImportsController < ApplicationController
  def create
    file = params[:file_report][:file]
    return json_response({ error: 'Required CSV File' }, :unprocessable_entity) if file.content_type != 'text/csv'

    import_svc = ImportCsv.new(file)
    import_svc.call
    if import_svc.success?
      json_response({ message: 'File Imported'}, :created)
    else
      json_response({ error: import_svc.error }, :unprocessable_entity)
    end
  end
end
