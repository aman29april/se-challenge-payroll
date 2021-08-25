class Api::FileImportsController < ApplicationController
  def create
    file = params[:file_report][:file]
    if file.content_type != 'text/csv'
      return json_response({ error: 'Required CSV File' }, :unprocessable_entity)
    end

    import_svc = ImportCsv.new(file)
    import_svc.import
    if import_svc.success?
      json_response({message: 'File Imported'})
    else
      json_response({ error: import_svc.error }, :unprocessable_entity)
    end
  end
end
