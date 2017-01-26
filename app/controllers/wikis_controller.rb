# This controller will trigger login, and handle our wiki CRUD methods
class WikisController < ApplicationController
  before_action :authenticate_user!

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    set_wiki_parameters

    if @wiki.save
      flash[:notice] = 'Wiki Saved!'
      redirect_to @wiki
    else
      flash.now[:alert] = 'Wiki could not be saved... Please confirm adequate characters and try again!'
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    set_wiki_parameters

    if @wiki.save
      flash[:notice] = 'Wiki Updated!'
      redirect_to @wiki
    else
      flash.now[:alert] = 'Wiki could not be updated... Please confirm adequate characters and try again!'
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = 'There was an error deleting the wiki.'
      render :show
    end
  end

  private

  def set_wiki_parameters
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
  end
end
