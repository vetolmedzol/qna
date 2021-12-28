class ApplicationDecorator < Draper::Decorator
  def object_author
    "Author: #{object.user.full_name}" if object.user
  end
end
