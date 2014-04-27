class WikisController < ApplicationController
  before_action :authenticate_user!

  def index
    @wikis = Wiki.paginate(page: params[:page], per_page: 10)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.create(wiki_params)
    @wiki.user = current_user

    if @wiki.save!
      flash[:notice] = "Your new Wiki has been created!"
      redirect_to wiki_path(@wiki)
    else
      flash[:error] = "There was a problem saving your Wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])

    if @wiki.update(wiki_params)
      redirect_to @wiki, notice: "Wiki Updated"
    else
      flash[:error] = "There was an error updating your wiki, please try again."
      render :edit
    end

  end

  private
    def wiki_params
      params.require(:wiki).permit(:title, :body, :description)      
    end
end
