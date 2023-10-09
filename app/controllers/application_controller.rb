class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization
  
end
