class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show edit update destroy]

  def index
    @questions = QuestionsDecorator.new(Question.all.ordered.page(params[:page]).per(10))
  end

  def show
    @answer = @question.answers.build
    @answer.attachments.build
  end

  def new
    @question = Question.new
    @question.attachments.build
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
    @question.update(question_params) && current_user.author_of?(@question)
  end

  def destroy
    @question.destroy! if current_user.author_of?(@question)
    redirect_to(questions_path)
  end

  private

  def find_question
    @question = Question.find(params[:id]).decorate
  end

  def question_params
    params.require(:question).permit(:title, :body, { attachments_attributes: [:file] })
  end
end
