require 'rails_helper'

RSpec.describe 'Api::PayrollReports', type: :request do
  let(:file_path) { "#{Rails.root}/spec/files/time-report-1.csv" }
  let(:file) {fixture_file_upload(file_path, 'text/csv', binary: true)}

  describe 'GET /index' do
    path '/api/payroll_reports' do
      get 'Get all time logs' do
        tags 'Payroll Report'
        produces 'application/json'

        response '200', 'Returns result' do
          schema '$ref' => '#/components/schemas/payroll_report_object'
          run_test!  do |response|
            data = JSON.parse(response.body)
            expect(data['payrollReport']['employeeReports']).to be_empty
          end
        end

        response '200', 'Returns result' do
          before { post '/api/file_imports',
                        params: {
                          file_report: { file: file }
                        }
          }

          schema '$ref' => '#/components/schemas/payroll_report_object'
          run_test!  do |response|
            data = JSON.parse(response.body)
            employees = data['payrollReport']['employeeReports']
            expect(employees).not_to be_empty
            debugger

            expect()
          end
        end

        # response 422, 'invalid request' do
        #   schema '$ref' => '#/components/schemas/errors_object'
        #
        #   run_test!
        # end
      end
    end
  end

  # path '/api/payroll_reports/{report_id}' do
  #   get 'Get all time logs' do
  #     tags 'Payroll Report'
  #     produces 'application/json'
  #     parameter name: :report_id, in: :path, type: :string
  #     response '200', 'Returns result' do
  #       schema '$ref' => '#/components/schemas/payroll_report_object'
  #
  #       let(:report_id) { 42 }
  #       run_test!
  #     end
  #
  #     response 422, 'invalid request' do
  #       schema '$ref' => '#/components/schemas/errors_object'
  #     end
  #   end
  # end
end
