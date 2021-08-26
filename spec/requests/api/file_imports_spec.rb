require 'swagger_helper'

RSpec.describe 'api/file_imports', type: :request, clean_as_group: true do
  let(:file_path) { "#{Rails.root}/spec/files/time-report-1.csv" }
  let(:file) { fixture_file_upload(file_path, 'text/csv', binary: true) }

  path '/api/file_imports' do
    post 'Import File' do
      tags 'Import'
      consumes 'multipart/form-data'
      produces 'application/json'
      parameter name: :file_report, in: :formData, type: :file,
                schema: { '$ref' => '#/components/schemas/upload_object' }
      response '200', 'File Imported' do
        schema '$ref' => '#/components/schemas/upload_success_object'

        let(:file_report) do
          {
            file: file
          }
        end
        run_test!
      end

      response '200', 'Import Empty File' do
        schema '$ref' => '#/components/schemas/upload_success_object'

        let(:file_report) do
          {
            file: fixture_file_upload("#{Rails.root}/spec/files/time-report-2.csv", 'text/csv', binary: true)
          }
        end
        run_test!
      end

      response '422', 'Same file (report id already present) uploaded again' do
        schema '$ref' => '#/components/schemas/errors_object'

        let(:file_report) do
          {
            file: file
          }
        end
        run_test!
      end
    end
  end
end
