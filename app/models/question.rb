class Question < ApplicationRecord
  validates :title, :body, presence: true

  has_many :answers, dependent: :destroy
  belongs_to :user

  scope :ordered, -> { order(created_at: :desc) }

  def best_answer
    answers.best_answers.first
  end
end
