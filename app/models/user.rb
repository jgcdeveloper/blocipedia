# This will handle user info via the devise gem
class User < ActiveRecord::Base
  has_many :wikis, foreign_key: "creator_id", dependent: :destroy
  after_initialize :set_role_to_standard, if: :new_record?

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:standard, :premium, :admin]

  # Method to handle upgrading user
  def upgrade_user
    set_role_to_premium
  end

  # Method to handle downgrading user
  def downgrade_user
    set_role_to_standard
  end

  private

  # Note that 1 represents premium in the DB
  def set_role_to_premium
    update(role: 1)
  end

  # Note that 0 represents standard in the DB
  def set_role_to_standard
    update(role: 0)
  end

end
