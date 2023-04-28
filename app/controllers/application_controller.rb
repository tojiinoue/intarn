class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top]
  before_action :confgure_permitted_parameters, if: :devise_controller?

  protected

  def confgure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
