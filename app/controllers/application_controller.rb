class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
 



  private
   # Deviseのサインアップ時に追加パラメータを許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
  end
end

