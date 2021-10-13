class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_byemail(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Bienvenido'
    else
      flash.now[:notice] = 'Acceso no autorizado'
      render action: new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Sesion cerrada'
  end

end
