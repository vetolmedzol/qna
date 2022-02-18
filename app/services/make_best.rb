class MakeBest
  def initialize(answer)
    @answer = answer
  end

  def call
    ActiveRecord::Base.transaction do
      unless @answer.best?
        @answer.question.answers.best_answers.each do |answer|
          answer.update!(best: false)
        end
      end
      @answer.update!(best: true)
    rescue ActiveRecord::RecordInvalid => e
      e.record.errors
    end
  end
end
