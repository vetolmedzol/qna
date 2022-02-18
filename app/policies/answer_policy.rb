class AnswerPolicy < ApplicationPolicy
  attr_reader :user, :record

  def update?
    @user.author_of?(@record)
  end

  def destroy?
    @user.author_of?(@record)
  end

  def make_best?
    @user.author_of?(@record.question)
  end
end
