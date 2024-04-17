class PagesController < ApplicationController
  def home
    @recent_posts = Post.limit(4).where("created_at >= ?", 1.hours.ago)
    @secondary_posts = @recent_posts.present? ? Post.where.not(id: @recent_posts.pluck(:id)).limit(@recent_posts.count * 2) : Post.limit(4)
    @tech = Post.joins(:category).where(categories: { title: 'technology' })
    
    @categories_with_posts = Category.joins(:post)
    .group('categories.id')
    .having('COUNT(posts.id) >= 2').limit(4)

    @locations_with_posts = Location.joins(:post)
    .group('locations.id')
    .having('COUNT(posts.id) >= 2').limit(4)

  end

  def contact
  end

  def about
  end
end
