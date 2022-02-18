class QuestionPolicy < ApplicationPolicy
  attr_reader :user, :record

  def update?
    @user.author_of?(@record)
  end

  def destroy?
    @user.author_of?(@record)
  end
end
