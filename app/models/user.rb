# This will handle user info via the devise gem
class User < ActiveRecord::Base
  has_many :wikis, dependent: :destroy
  after_initialize :set_user_default, if: :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:admin, :standard, :premium]

  private

  def set_user_default
    self.role = 'standard'
  end
end
