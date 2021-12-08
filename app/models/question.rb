class Question < ApplicationRecord
  validates :title, :body, presence: true

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :attachments

  scope :ordered, -> { order(created_at: :desc) }

  def best_answer
    answers.best_answers.first
  end
end
