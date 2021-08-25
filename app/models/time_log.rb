class TimeLog < ApplicationRecord
  monetize :wage_cents
  # validates :wage_cents, numericality: { greater_than: 0 }

  belongs_to :file_import, foreign_key: :report_id

  delegate :report_id, to: :file_import

  def self.group_rates
    {
      'A': 20,
      'B': 30
    }
  end
end
