class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :destroy

  def full_name
    [first_name, last_name].filter(&:presence).compact.map(&:strip) * ' '
  end

  def author_of?(resource)
    id == resource.user_id
  end
end
