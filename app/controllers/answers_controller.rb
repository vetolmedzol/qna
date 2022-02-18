class AnswersController < ApplicationController
  rescue_from Pundit::NotAuthorizedError, with: :error_render_method
  before_action :authenticate_user!
  before_action :question
  before_action :answers
  before_action :answer, except: %i[new create]
  before_action :authorize_answer, only: %i[update destroy make_best]

  def new
    @answer = @question.answers.build
    @answer.attachments.build
  end

  def create
    @answer = @question.answers.create(answer_params.merge({ user: current_user }))
  end

  def update
    @answer.update!(answer_params)
  end

  def destroy
    @answer.destroy!
  end

  def make_best
    MakeBest.new(@answer).call
  end

  private

  def authorize_answer
    authorize @answer
  end

  def answer
    @answer ||= @question.answers.find(params[:id])
  end

  def question
    @question ||= Question.find(params[:question_id])
  end

  def answers
    @answers ||= RatingAnswer.includes(:user).where(question_id: @question.id)
  end

  def answer_params
    params.require(:answer).permit(:title, { attachments_attributes: [:file] })
  end
end
