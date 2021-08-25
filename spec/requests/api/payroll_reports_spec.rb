require 'rails_helper'

RSpec.describe 'Api::PayrollReports', type: :request do
  describe 'GET /index' do
    path '/api/payroll_reports' do
      get 'Get all time logs' do
        tags 'Payroll Report'
        produces 'application/json'
        response '200', 'Returns result' do
          schema '$ref' => '#/components/schemas/payrollReportObject'

          run_test!
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
  #       schema '$ref' => '#/components/schemas/payrollReportObject'
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
