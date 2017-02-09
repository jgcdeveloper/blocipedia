# This will handle user info via the devise gem
class User < ActiveRecord::Base
  has_many :wikis, dependent: :destroy
  after_initialize :set_default_role, if: :new_record?

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

  def set_default_role
  end

  # Note that 1 represents premium in the DB
  def set_role_to_premium
    update_attribute('role',1)
  end

  # Note that 0 represents standard in the DB
  def set_role_to_standard
    update_attribute('role',0)
  end
end
