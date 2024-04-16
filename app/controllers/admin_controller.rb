class AdminController < ApplicationController
  before_action :authenticate_user!, except: []
    layout 'action'
    
    def dashboard
      @users = User.where.not(id: current_user.id)
      authorize! :manage, @users
    end

    def destroy_user
      @user = User.find(params[:id])
      authorize! :destroy, @user
      @user.destroy
      redirect_to admin_path, notice: 'User was successfully deleted.'
    end

    def promote
      user = User.find(params[:id])
      if user.has_role?(:viewer)
        user.remove_role(:viewer)
        user.add_role(:writer)
        redirect_to admin_path, notice: 'User promoted to writer.'
      elsif user.has_role?(:writer)
        user.remove_role(:writer)
        user.add_role(:moderator)
        redirect_to admin_path, notice: 'User promoted to moderator.'
      elsif user.has_role?(:moderator)
        user.remove_role(:moderator)
        user.add_role(:admin)
        redirect_to admin_path, notice: 'User promoted to admin.'
      else
        redirect_to admin_path, alert: 'User already has the highest role.'
      end
    end
  
    def demote
      user = User.find(params[:id])
      if user.has_role?(:admin)
        user.remove_role(:admin)
        user.add_role(:moderator)
        redirect_to admin_path, notice: 'User demoted to moderator.'
      elsif user.has_role?(:moderator)
        user.remove_role(:moderator)
        user.add_role(:writer)
        redirect_to admin_path, notice: 'User demoted to writer.'
      elsif user.has_role?(:writer)
        user.remove_role(:writer)
        user.add_role(:viewer)
        redirect_to admin_path, notice: 'User demoted to viewer.'
      else
        redirect_to admin_path, alert: 'User already has the lowest role.'
      end
    end

    
    private

end