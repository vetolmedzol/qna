class QuestionsController < ApplicationController
  rescue_from Pundit::NotAuthorizedError, with: :error_render_method
  before_action :authenticate_user!, except: %i[index show]
  before_action :question, only: %i[show edit update destroy]
  before_action :authorize_question, only: %i[update destroy]

  def index
    @questions = QuestionsDecorator.new(Question.includes(:user).all.ordered.page(params[:page]).per(10))
  end

  def show
    @answer = @question.answers.build
    @answer.attachments.build
    @question = @question.decorate
    @answers = RatingAnswer.includes(:user).where(question_id: @question.id)
  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def edit; end

  def create
    @question = Question.new(question_params.merge({ user: current_user }))
    if @question.save
      flash[:notice] = 'Your question successfully created!'
      redirect_to(@question)
    else
      render(:new)
    end
  end

  def update
    @question.update(question_params)
  end

  def destroy
    @question.destroy!
    redirect_to(questions_path)
  end

  private

  def authorize_question
    authorize(@question)
  end

  def question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, { attachments_attributes: [:file] })
  end
end
