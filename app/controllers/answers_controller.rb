class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question
  before_action :find_answer, except: %i[new create]

  def new
    @answer = @question.answers.build
    @answer.attachments.build
  end

  def create
    @answer = @question.answers.create(answer_params.merge({ user: current_user }))
  end

  def update
    @answer.update!(answer_params) if current_user.author_of?(@answer)
  end

  def destroy
    @answer.destroy! if current_user.author_of?(@answer)
  end

  def make_best
    @answer.make_best! if current_user.author_of?(@question)
  end

  private

  def find_answer
    @answer = @question.answers.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:title, { attachments_attributes: [:file] })
  end
end
