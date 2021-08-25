class TimeLog < ApplicationRecord
  monetize :wage_cents

  belongs_to :file_import

  delegate :report_id, to: :file_import

  def self.group_rates
    {
      'A': 20,
      'B': 30
    }
  end
end
