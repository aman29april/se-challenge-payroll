class Api::PayrollReportsController < ApplicationController

  def index
    transformer = PayrollReportTransformer.new
    json_response({ payrollReport: PayrollReportQuery.get_all(transformer) })
  end

end
