class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question

  def new
    @answer = @question.answers.build
  end

  def create
    @answer = @question.answers.build(answer_params.merge({ user: current_user }))
    if @answer.save
      redirect_to(@question)
    else
      render(:new)
    end
  end

  def destroy
    answer = @question.answers.find(params[:id])
    answer.destroy! if current_user.author_of?(answer)
    redirect_to(@question)
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:title)
  end
end
