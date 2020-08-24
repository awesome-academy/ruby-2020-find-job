class SearchesController < ApplicationController
  def index
    @search = Post.posts_start_date(params).search_posts(params).posts_salary params
    @feed_items = @search.page(params[:page]).per Settings.notification_per_page
  end
end
