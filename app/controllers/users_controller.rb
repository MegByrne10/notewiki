class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @user = User.find(params[:id])
    @wikis = Wiki.where(user: current_user).paginate(page: params[:page], per_page:10)
  end
end
