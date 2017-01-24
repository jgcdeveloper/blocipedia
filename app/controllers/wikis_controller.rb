# This controller will handle our about and index views and log us in
class WikisController < ApplicationController
  before_action :authenticate_user!

  def index
    @wikis = Wiki.all
  end

  def show; end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end
end
