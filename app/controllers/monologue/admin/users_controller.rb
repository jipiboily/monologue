class Monologue::Admin::UsersController < Monologue::Admin::BaseController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash.notice = "User modified"
    end
    render :edit
  end
end