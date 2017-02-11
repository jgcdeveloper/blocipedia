# This is the authorization policy for our wiki
class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  # create_eligable_roles
  def create?
    create_eligable_roles
  end

  def update?
    update_eligable_roles
  end

  def destroy?
    destroy_eligable_roles
  end

  private

  # Currently standard, premium, and admin roles have create permission
  def create_eligable_roles
    @user.premium? or
    @user.admin? or
    @user.standard?
  end

  # Currently standard, premium, and admin roles have update permission
  def update_eligable_roles
    @user.premium? or
    @user.admin? or
    @user.standard?
  end

  # Currently admin roles and wiki owner have delete permission
  def destroy_eligable_roles
    @user.admin? or
    @wiki.user_id == @user.id
  end
end
