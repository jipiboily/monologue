class Monologue::Admin::SessionsController < Monologue::Admin::BaseController
  skip_before_filter :authenticate_user!, only: [:new, :create]
  before_filter :already_authenticated!, only: [:new, :create]

  def new
  end

  def create
    user = Monologue::User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:monologue_user_id] = user.id
      redirect_to admin_url, notice: t("monologue.admin.sessions.messages.logged_in")
    else
      flash.now.alert = t("monologue.admin.sessions.messages.invalid")
      render "new"
    end
  end

  def destroy
    session[:monologue_user_id] = nil
    redirect_to admin_url, notice: t("monologue.admin.sessions.messages.logged_out")
  end

private
  def already_authenticated!
    redirect_to admin_url, alert: t("monologue.admin.sessions.messages.already_authenticated") if monologue_current_user
  end
end