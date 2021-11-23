class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :find_question

  def show
    @answer = @question.answers.find(params[:id])
  end

  def new
    @answer = @question.answers.build
  end

  def create
    @answer = @question.answers.build(answer_params)
    if @answer.save
      redirect_to(question_path(@question))
    else
      render(:new)
    end
  end

  def destroy
    @question.answers.find(params[:id]).destroy!
    redirect_to(question_path(@question))
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:title)
  end
end
