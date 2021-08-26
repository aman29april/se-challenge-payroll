class PayrollReportTransformer
  def self.transform(records)
    {
      employeeReports: records.map do |time_log|
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
    }
  end

  def self.get_end_date(date)
    date.day <= 15 ? date.beginning_of_month + 14 : date.end_of_month
  end

  def self.amount_string(cents)
    (cents / 100).to_money.format
  end
end
