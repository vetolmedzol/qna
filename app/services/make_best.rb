class MakeBest
  def initialize(answer)
    @answer = answer
  end

  def call
    ActiveRecord::Base.transaction do
      unless @answer.best?
        @answer.question.answers.each do |answer|
          answer.update!(best: false)
        end
      end
      @answer.update!(best: true)
    end
  end
end
