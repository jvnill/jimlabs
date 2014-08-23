class ApplicationController < ActionController::Base
  USERS = { ENV['DIGEST_USERNAME'] => ENV['DIGEST_PASSWORD'] }

  protect_from_forgery

  private

  def login_required
    authenticate_or_request_with_http_digest do |username|
      USERS[username]
    end
  end
end
