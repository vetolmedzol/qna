class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true
  after_create :refresh_rating_answers

  mount_uploader :file, FileUploader

  private

  def refresh_rating_answers
    RatingAnswer.refresh
  end
end
