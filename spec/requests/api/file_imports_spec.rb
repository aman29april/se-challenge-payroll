require 'swagger_helper'

RSpec.describe 'api/file_imports', type: :request do
  path '/api/file_imports' do
    post 'Import File' do
      tags 'Import'
      consumes 'multipart/form-data'
      produces 'application/json'
      parameter name: :file_report, in: :body, schema: {
        type: :object,
        properties: {
          'file_report[file]': { type: :string, format: 'binary', nullable: false }
        },
        required: ['file_report[file]']
      }

      response '200', 'File Imported' do
        schema type: :object,
               properties: {
                 message: 'File Imported'
               },
               required: ['message']

        run_test!
      end

      response 422, 'invalid request' do
        schema '$ref' => '#/components/schemas/errors_object'
      end
    end
  end

  path '/api/payroll_reports' do
    get 'Get all time logs' do
      tags 'Payroll Report'
      produces 'application/json'
      response '200', 'Returns result' do
        schema '$ref' => '#/components/schemas/payrollReportObject'
        run_test!
      end

      response 422, 'invalid request' do
        schema '$ref' => '#/components/schemas/errors_object'
      end
    end
  end

  path '/api/payroll_reports/{report_id}' do
    get 'Get all time logs' do
      tags 'Payroll Report'
      produces 'application/json'
      parameter name: :report_id, in: :path, type: :string
      response '200', 'Returns result' do
        schema '$ref' => '#/components/schemas/payrollReportObject'

        let(:report_id) { 42 }
        run_test!
      end

      response 422, 'invalid request' do
        schema '$ref' => '#/components/schemas/errors_object'
      end
    end
  end
end
