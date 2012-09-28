class Monologue::Admin::UsersController < Monologue::Admin::BaseController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    logger.debug params.inspect
    logger.debug params[:user][:password]
    logger.debug params[:user][:password].class
    params[:user][:password].delete if params[:user][:password].empty?
    params[:user][:password_confirmation].delete if params[:user][:password_confirmation].empty?
    logger.debug params.inspect
    if @user.update_attributes(params[:user])
      flash.notice = "User modified"
    end
    render :edit
  end
end