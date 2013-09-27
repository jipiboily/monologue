class Monologue::Admin::BaseController < Monologue::ApplicationController
  include Monologue::ControllerHelpers::User
  include Monologue::ControllerHelpers::Auth

  force_ssl if Monologue.admin_force_ssl # TODO: find a way to test that with capybara
  
  layout "layouts/monologue/admin"
end