class PagesController < ApplicationController
  def home
    @main_posts = Post.limit(4).where("created_at >= ?", 3.hours.ago)
    @secondary_posts = Post.offset(3).limit(5)
  end

  def contact
  end

  def about
  end
end
