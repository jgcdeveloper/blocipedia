# This controller will redirect to login, and handle our RESTful routes
class WikisController < ApplicationController
  before_action :authenticate_user!
  before_action :create_new_wiki, only: [:new, :create]
  before_action :find_wiki, only: [:show, :edit, :update, :destroy]

  def index
    @wikis = Wiki.all
  end

  def show
    #See before_action
  end

  def new
    #see before_action
  end

  def create
    set_wiki_parameters

    if @wiki.save
      flash[:notice] = 'Wiki was saved'
      redirect_to @wiki
    else
      flash.now[:alert] = 'Wiki could not be saved, please try again'
      render :new
    end
  end

  def edit
    #See before_action
  end

  def update
    set_wiki_parameters

    if @wiki.save
      flash[:notice] = 'Wiki was updated'
      redirect_to @wiki
    else
      flash.now[:alert] = 'Wiki could not be updated, please try again'
      render :new
    end
  end

  def destroy

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = 'There was an error deleting the wiki.'
      render :show
    end
  end

  private

  def create_new_wiki
    @wiki = Wiki.new
  end

  def find_wiki
    @wiki = Wiki.find(params[:id])
  end

  def set_wiki_parameters
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
  end
end
