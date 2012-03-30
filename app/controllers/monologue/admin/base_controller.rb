class Monologue::Admin::BaseController < Monologue::ApplicationController
  before_filter :authenticate_user!
  force_ssl if Monologue.admin_force_ssl # TODO: find an great way to that with capybara
  
  layout "layouts/monologue/admin"
  
  def authenticate_user!
    if current_user.nil?
      redirect_to admin_login_url, :alert => "You must first log in to access admin section."
    end
  end
end