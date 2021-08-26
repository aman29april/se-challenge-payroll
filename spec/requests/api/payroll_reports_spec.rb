require 'rails_helper'
require 'json'

RSpec.describe 'Api::PayrollReports', type: :request do
  let(:file_path) { "#{Rails.root}/spec/files/time-report-1.csv" }
  let(:file) { fixture_file_upload(file_path, 'text/csv', binary: true) }

  describe 'GET /index' do
    path '/api/payroll_reports' do
      get 'Get all time logs' do
        tags 'Payroll Report'
        produces 'application/json'

        response '200', 'When there is no data, employeeReports should be empty array' do
          schema '$ref' => '#/components/schemas/payroll_report_object'
          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['payrollReport']['employeeReports']).to be_empty
          end
        end

        response '200', 'Non empty array if there are time log entires' do
          # create some data
          before do
            post '/api/file_imports',
                 params: {
                   file_report: { file: file }
                 }
          end
          schema '$ref' => '#/components/schemas/payroll_report_object'
          run_test! do |response|
            data = JSON.parse(response.body).deep_symbolize_keys
            expect(data).to match(
              "payrollReport": {
                "employeeReports": [
                  {
                    "employeeId": '1',
                    "payPeriod": {
                      "startDate": '2023-01-01',
                      "endDate": '2023-01-15'
                    },
                    "amountPaid": '$300.00'
                  },
                  {
                    "employeeId": '1',
                    "payPeriod": {
                      "startDate": '2023-01-16',
                      "endDate": '2023-01-31'
                    },
                    "amountPaid": '$80.00'
                  },
                  {
                    "employeeId": '2',
                    "payPeriod": {
                      "startDate": '2023-01-16',
                      "endDate": '2023-01-31'
                    },
                    "amountPaid": '$90.00'
                  }
                ]

              }.deep_symbolize_keys
            )
          end
        end
      end
    end
  end
end
