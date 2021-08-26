class PayrollReportTransformer

  def transform(records)
    {
      employeeReports: transformed_array(records)
    }
  end

  private

  def transformed_array(records)
    records.map do |time_log|
      start_date = time_log['start_date'].to_date

      {
        employeeId: time_log['employee_id'].to_s,
        payPeriod: {
          startDate: start_date,
          endDate: get_end_date(start_date)
        },
        amountPaid: amount_string(time_log['total_wage'])
      }
    end
  end

  # end date of bi week will be either 15 or last day of month
  def get_end_date(date)
    date.day <= 15 ? date.beginning_of_month + 14 : date.end_of_month
  end

  def amount_string(cents)
    (cents / 100).to_money.format
  end
end
