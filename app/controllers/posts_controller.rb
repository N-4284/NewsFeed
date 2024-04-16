class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :authorize_user!, only: [:edit, :destroy]
  # GET /posts or /posts.json
  def index
    @posts = if params[:search].present?
            Post.where("title LIKE ?", "%#{params[:search]}%")
    elsif params[:category].present?
      Post.by_category_name(params[:category])
    elsif params[:loc].present?
      Post.by_location(params[:loc])
    else
      Post.all
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  def dashboard
    @posts = current_user.posts 
  end

  # GET /posts/new
  def new
    @post = Post.new
    authorize! :create, @post
    #byebug
    @categories = Category.all.pluck(:title, :id) # Fetch categories from the database
    @locations = Location.all.pluck(:title, :id)
    render layout: "action"
  end

  # GET /posts/1/edit
  def edit
    @post = current_user.posts.find(params[:id])
    @categories = Category.all.map { |category| [category.title, category.id] }
    @locations = Location.all.map {|location| [location.title, location.id] }
    render layout: "action"
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)
    @categories = Category.all.map { |category| [category.title, category.id] }
    @locations = Location.all.map {|location| [location.title, location.id] }
    if params[:post][:thumbnail].present?
      @post.thumbnail.attach(params[:post][:thumbnail])
    end 

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to dashboard_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def authorize_user!
      unless current_user == @post.author
        flash[:alert] = "You are not authorized to delete this post."
        redirect_to @post
        #^use better alert currenlty only prevntion
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit( :title, :body, :thumbnail, :category_id, :location_id)
    end
end
