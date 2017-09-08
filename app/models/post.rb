# frozen_string_literal: true

# A short post with a picture from a user
class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 5000 }
  validate  :picture_size

  private

  # Validates the size of an uploaded picture.
  def picture_size
    return unless picture.size > 5.megabytes
    errors.add(:picture, t('errors.maximum_file_size'))
  end
end
