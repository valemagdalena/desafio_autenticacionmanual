class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to root_path, notice: 'User Creado' }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @stories = @user.stories
  end

  def destroy_session
    session[:user_id] = nil
    redirect_to root_path, notice: 'Session Closed'
  end

  private

    def set_user
      @user = User.find(params[:id].to_i)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

end