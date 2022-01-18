class RatingAnswer < ApplicationRecord
  has_many :attachments, as: :attachable
  belongs_to :user
  belongs_to :question

  self.primary_key = :id

  def self.refresh
    Scenic.database.refresh_materialized_view(:rating_answers, concurrently: false, cascade: false)
  end

  def readonly?
    true
  end
end
