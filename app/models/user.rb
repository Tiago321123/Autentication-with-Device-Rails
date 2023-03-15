class User < ApplicationRecord
  validates :name, presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def authenticate(email, password)
  user = User.find_for_authentication(email: email)
  user if user&.valid_password?(password)
  end
  
end
