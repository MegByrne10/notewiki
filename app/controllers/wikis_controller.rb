class WikisController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    if params[:search]
      @wikis = policy_scope(Wiki).search(params[:search]).alphabetical.paginate(page: params[:page], per_page: 10)
    else
      @wikis = policy_scope(Wiki).alphabetical.paginate(page: params[:page], per_page: 10)
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.create(wiki_params)
    authorize @wiki
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Your new Wiki has been created!"
      redirect_to wiki_path(@wiki)
    else
      flash[:error] = "#{@wiki.errors.messages}"
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update(wiki_params)
      redirect_to @wiki, notice: "Wiki Updated"
    else
      #flash[:error] = "There was an error updating your wiki, please try again."
      render :edit
    end

  end

  private
    def wiki_params
      params.require(:wiki).permit(:title, :body, :description, :private, :users, user_ids: [])      
    end

    def search_params
      params.require(:search).permit(:search)
    end
end
