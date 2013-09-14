module MonologueSpecHelper
  module AuthenticationMock
    def sign_in_as user
      session[:user_id] = user.id
    end
  end
end

RSpec.configure do |config|
  config.include MonologueSpecHelper::AuthenticationMock, type: :controller
end