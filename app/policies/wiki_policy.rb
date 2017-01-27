class WikiPolicy < ApplicationPolicy

  attr_reader :user, :wiki

  def initialize(user, post)
    @user = user
    @post = post
  end

  def destroy?
    user.admin?
  end

  def update?
    user.standard?
  end

  def create?
    user.standard?
  end
end
