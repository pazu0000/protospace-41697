class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!,unless: :devise_controller?

  private
   # Deviseのサインアップ時に追加パラメータを許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
  end

   # 未ログインユーザーがアクセスした場合、トップページにリダイレクト
   def authenticate_user!
    unless user_signed_in?
      redirect_to root_path, alert: "ログインが必要です。"
    end
   end 
end