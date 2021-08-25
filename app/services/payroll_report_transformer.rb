class PayrollReportTransformer
  def self.transform(records)
    {
      employeeReports: records.map do |time_log|
        start_date = time_log['start_date'].to_date
        {
          employeeId: time_log['employee_id'].to_s,
          payPeriod: {
            start_date: start_date,
            end_date: get_end_date(start_date)
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
    money = (cents / 100).to_money
    money.format
  end
end
