class Answer < ApplicationRecord
  validates :title, presence: true

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :attachments

  scope :best_answers, -> { where(best: true) }
end
