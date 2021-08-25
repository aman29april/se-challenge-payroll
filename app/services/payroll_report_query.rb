module PayrollReportQuery
  FIELDS = <<~HEREDOC
      employee_id,
        sum(wage_cents) as total_wage,
        CASE
            WHEN EXTRACT(DAY FROM date) > 15 THEN TO_CHAR(date , 'yyyy-mm-16')::date
            ELSE TO_CHAR(date, 'yyyy-mm-01')::date
            END as start_date
      HEREDOC

  GROUP_BY = "GROUP BY employee_id, start_date"

  ORDER_BY = "ORDER BY start_date, employee_id"

  ALL_QUERY = <<~HEREDOC
    select  #{FIELDS} from time_logs
      #{GROUP_BY}
      #{ORDER_BY}
  HEREDOC



  def self.get_all
    records = ActiveRecord::Base.connection.execute(ALL_QUERY)
    PayrollReportTransformer.transform(records)
  end

  def self.filter(report_id:)
    records = ActiveRecord::Base.connection.execute(filter_query(report_id.to_i))
    PayrollReportTransformer.transform(records)
  end

  def self.filter_query(report_id)
    <<~HEREDOC
    select  #{FIELDS} from time_logs
      where report_id = #{report_id}
      #{GROUP_BY}
      #{ORDER_BY}
    HEREDOC
  end
end
