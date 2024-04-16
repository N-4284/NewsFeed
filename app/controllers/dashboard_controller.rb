class DashboardController < ApplicationController
  before_action :authenticate_user!, only: [:index, :dashboard]

  layout 'action'

  def index
    @posts = current_user.posts 
    
  end
  
  def dashboard

  end

end