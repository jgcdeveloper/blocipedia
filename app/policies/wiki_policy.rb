# This is the authorization policy for our wiki
class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def destroy?
    user.admin?
    wiki.user_id == user.id
  end

  def update?
    if wiki.private
      user.premium?
      wiki.user_id == user.id
    else
      user.standard?
    end
  end

  def create?
    user.standard?
  end
end
