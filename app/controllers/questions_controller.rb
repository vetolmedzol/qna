class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show edit update destroy]

  def index
    @questions = Question.all.page(params[:page]).per(5)
  end

  def show; end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      flash[:notice] = 'Your question successfully created!'
      redirect_to(@question)
    else
      render(:new)
    end
  end

  def update
    if @question.update(question_params) && current_user.author_of?(@question)
      redirect_to(@question)
    else
      render(:edit)
    end
  end

  def destroy
    @question.destroy! if current_user.author_of?(@question)
    redirect_to(questions_path)
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
