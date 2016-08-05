class Video < ActiveRecord::Base
  validates :video_id, presence: true
  validates :title, presence: true
  validates :duration, numericality: { greater_than: 0 }
  validates :file_size, numericality: { greater_than: 0 }
  validate :upload_date, :valid_date?

  def valid_date?
    date = upload_date_before_type_cast
    begin
      Date.parse(date)
    rescue
      errors.add(:upload_date, "invalid date is passed")
    end
  end

  def to_param
    video_id
  end
end
