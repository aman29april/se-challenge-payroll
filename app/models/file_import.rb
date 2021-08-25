class FileImport < ApplicationRecord
  validates :report_id, presence: true, uniqueness: {message: "already exists"}
  has_many :time_logs, autosave: true, dependent: :destroy

end
