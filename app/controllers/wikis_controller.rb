# This controller will redirect to login and handle our wiki CRUD methods
class WikisController < ApplicationController
  before_action :authenticate_user!

  def index
    @wikis = Wiki.order("updated_at DESC")
    @my_public_wikis = current_user.wikis.where(private: false)
    @my_premium_wikis = current_user.wikis.where(private: true)
    @my_collaborations = current_user.collaborations
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @user = current_user
    @wiki = @user.wikis.new
  end

  def create
    @user = current_user
    @wiki = @user.wikis.new(wiki_parameters)
    authorize @wiki

    if @wiki.save
      flash[:notice] = wiki_instantiate_confirmed
      redirect_to @wiki
    else
      flash.now[:alert] = wiki_instantiate_denied
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update(wiki_parameters)
      flash[:notice] = wiki_update_confirmed
      redirect_to @wiki
    else
      flash.now[:alert] = wiki_update_denied
      render :new
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = wiki_destroy_confirmed
      redirect_to wikis_path
    else
      flash.now[:alert] = wiki_destroy_denied
      render :show
    end
  end

  private

  def wiki_parameters
    params.require(:wiki).permit(:title, :body, :private)
  end

  # Messages for our alerts
  def wiki_instantiate_confirmed
    'Wiki has been created!'
  end

  def wiki_instantiate_denied
    "Error - Wiki could not be created...
    Please confirm character lengths and try again!"
  end

  def wiki_update_confirmed
    'Wiki has been updated!'
  end

  def wiki_update_denied
    "Error - Wiki could not be updated...
    Please confirm character lengths and try again!"
  end

  def wiki_destroy_confirmed
    "\"#{@wiki.title}\" was deleted successfully."
  end

  def wiki_destroy_denied
    'There was an error deleting the wiki.'
  end
end
