# This controller will handle our about and index views and log us in
class WikisController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
