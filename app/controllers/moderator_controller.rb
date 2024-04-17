class ModeratorController < ApplicationController
    before_action :authenticate_user!, except: []

      
      def dashboard
        @posts = Post.all
        authorize! :destroy, @posts
      end
#post  
      def destroy_post
        @post = Post.find(params[:id])
        authorize! :destroy, @post
        @post.destroy
        redirect_to moderator_path, notice: 'Post was successfully deleted.'
      end    
#Categories
      def manageCate
        @categories = Category.all
        authorize! :manage, @category
      end

      def new_category
        @category = Category.new
      end

      def edit_category
        @category = Category.find(params[:id])
      end

      def update_category
        @category = Category.find(params[:id])
        if @category.update(category_params)
          redirect_to moderator_categories_path, notice: 'Category was successfully updated.'
        else
          render :edit_category
        end
      end

      def create_category
        @category = Category.new(category_params)
        if @category.save
          redirect_to moderator_categories_path, notice: 'Category was successfully created.'
        else
          render :new_category
        end
      end

      def destroy_category
        @category = Category.find(params[:id])
        authorize! :destroy, @category
        
        if @category.id != 8
          
          @category.post.update_all(category_id: 8)
          @category.destroy
          
          redirect_to moderator_categories_path, notice: 'Category were successfully deleted.'
        else
          redirect_to moderator_categories_path, alert: 'Category cannot be deleted.'
        end
      end 
#locations
      def manageLoc
        @locations = Location.all
        authorize! :manage, @Location
      end

      def new_location
        @location = Location.new
      end

      def edit_location
        @location = Location.find(params[:id])
      end

      def update_location
        @location = Location.find(params[:id])
        if @location.update(location_params)
          redirect_to moderator_locations_path, notice: 'Location was successfully updated.'
        else
          render :edit_location
        end
      end

      def create_location
        @location = Location.new(location_params)
        if @location.save
          redirect_to moderator_locations_path, notice: 'Location was successfully created.'
        else
          render :new_category
        end
      end

      def destroy_location
        @location = Location.find(params[:id])
        authorize! :destroy, @location
        if @location.id != 10

          @location.post.update_all(location_id: 10)
                
          @location.destroy
          
          redirect_to moderator_locations_path, notice: 'Location were successfully deleted.'
        else
          redirect_to moderator_locations_path, alert: 'Category cannot be deleted.'
        end
      end 
      
      private

      def category_params
        params.require(:category).permit(:title, :description)
      end

      def location_params
        params.require(:location).permit(:title)
      end
  
  end