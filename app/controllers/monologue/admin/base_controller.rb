class Monologue::Admin::BaseController < Monologue::ApplicationController
  before_filter :authenticate_user!
  force_ssl if Monologue.admin_force_ssl # TODO: find a way to test that with capybara
  
  layout "layouts/monologue/admin"
  
  def authenticate_user!
    if current_user.nil?
      redirect_to admin_login_url, :alert => I18n.t("monologue.admin.login.need_auth")
    end
  end
end