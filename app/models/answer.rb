class Answer < ApplicationRecord
  validates :title, presence: true
  after_commit :refresh_rating_answers

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :attachments

  scope :best_answers, -> { where(best: true) }

  private

  def refresh_rating_answers
    RatingAnswer.refresh
  end
end
