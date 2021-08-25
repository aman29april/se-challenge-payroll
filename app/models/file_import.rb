class FileImport < ApplicationRecord
  self.primary_key = :report_id

  validates :report_id, presence: true, uniqueness: { message: 'already exists' }
  has_many :time_logs, autosave: true, dependent: :destroy, foreign_key: :report_id, class_name: :TimeLog
end
