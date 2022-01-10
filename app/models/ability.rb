# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def authorize!(action, subject, *extra_args)
    subject_arg = subject.is_a?(Draper::Decorator) ? subject.model : subject
    super(action, subject_arg, *extra_args)
  end

  def initialize(user)
    can(:read, Question)

    return if user.blank?

    can(:read, Question, user: user)
  end
end
