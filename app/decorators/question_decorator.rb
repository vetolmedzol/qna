class QuestionDecorator < ApplicationDecorator
  delegate_all

  def asked_at
    helpers.content_tag(:span) do
      "The question was asked on #{object.created_at.strftime('%a %m/%d/%y')}"
    end
  end
end
