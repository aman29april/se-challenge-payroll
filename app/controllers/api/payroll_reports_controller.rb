class Api::PayrollReportsController < ApplicationController
  def index
    json_response({ payrollReport: PayrollReportQuery.get_all })
  end

  def show
    json_response({ payrollReport: PayrollReportQuery.filter(report_id: params[:id]) })
  end
end
