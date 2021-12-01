class Answer < ApplicationRecord
  validates :title, presence: true

  belongs_to :question
  belongs_to :user

  scope :best_answers, -> { where(best: true) }
  scope :not_best_answers, -> { where(best: false) }

  def make_best!
    ActiveRecord::Base.transaction do
      unless best?
        question.answers.each do |answer|
          answer.update(best: false)
        end
      end
      update!(best: true)
    end
  end
end
