class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @user = User.find(params[:id])
    @wikis = Wiki.where(user: current_user)
    @wikis += Wiki.includes(:collaborations).where('collaborations.user = ?', current_user)

    if params[:search]
      @wikis.search(params[:search]).recent.paginate(page: params[:page], per_page:10)
    else
      @wikis.recent.paginate(page: params[:page], per_page:10)
    end
  end
end
