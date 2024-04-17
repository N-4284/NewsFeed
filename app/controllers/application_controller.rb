class ApplicationController < ActionController::Base
  before_action :load_categories
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, alert: "You are not authorized to perform this action."
    end

    protected

         def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :firstname, :lastname,:profile_picture, :password, :password_confirmation, :current_password)}
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :firstname, :lastname, :profile_picture, :password)}
            #devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me)}

         end
         
         def load_categories
          @categories = Category.all
        end
end
