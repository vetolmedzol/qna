class RatingAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  self.primary_key = :id

  def self.refresh
    Scenic.database.refresh_materialized_view(:rating_answers, concurrently: false, cascade: false)
  end

  def attachments
    attachments_ids = RatingAnswer.find(id).attachments_ids
    Attachment.where(id: attachments_ids) if attachments_ids.any?
  end

  def readonly?
    true
  end
end
