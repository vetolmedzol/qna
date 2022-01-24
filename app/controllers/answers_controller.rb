class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :question
  before_action :answers
  before_action :find_answer, except: %i[new create]
  after_action :refresh_answers

  def new
    @answer = @question.answers.build
    @answer.attachments.build
  end

  def create
    @answer = @question.answers.create(answer_params.merge({ user: current_user }))
    refresh_answers
  end

  def update
    @answer.update!(answer_params) if current_user.author_of?(@answer)
    refresh_answers
  end

  def destroy
    @answer.destroy! if current_user.author_of?(@answer)
    refresh_answers
  end

  def make_best
    MakeBest.new(@answer).call if current_user.author_of?(@question)
  end

  private

  def refresh_answers
    RatingAnswer.refresh
  end

  def find_answer
    @answer = @question.answers.find(params[:id])
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def answers
    @answers = RatingAnswer.includes(:user).where(question_id: @question.id)
  end

  def answer_params
    if params[:rating_answer]
      params.require(:rating_answer).permit(:title, { attachments_attributes: [:file] })
    else
      params.require(:answer).permit(:title, { attachments_attributes: [:file] })
    end
  end
end
