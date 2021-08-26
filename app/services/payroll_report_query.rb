class PayrollReportQuery

  #If data is greater than 15, it is converted to 16 else it is converted to 01.
  FIELDS = <<~HEREDOC
    employee_id,
      sum(wage_cents) as total_wage,
      CASE
          WHEN EXTRACT(DAY FROM date) > 15 THEN TO_CHAR(date , 'yyyy-mm-16')::date
          ELSE TO_CHAR(date, 'yyyy-mm-01')::date
          END as start_date
  HEREDOC

  GROUP_BY = 'GROUP BY employee_id, start_date'

  ORDER_BY = 'ORDER BY employee_id, start_date'

  ALL_QUERY = <<~HEREDOC
    select  #{FIELDS} from time_logs
      #{GROUP_BY}
      #{ORDER_BY}
  HEREDOC

  def self.get_all(transformer)
    records = ActiveRecord::Base.connection.execute(ALL_QUERY)
    transformer.transform(records)
  end

end
