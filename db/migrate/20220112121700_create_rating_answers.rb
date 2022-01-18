class CreateRatingAnswers < ActiveRecord::Migration[6.1]
  def change
    create_view :rating_answers, materialized: true
  end
end
