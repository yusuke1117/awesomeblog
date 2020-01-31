class StaticPagesController < ApplicationController
  def home
      # @micropost = current_user.microposts.build if logged_in?
      #we are going to show all the posts from diffrent users


      # @micropost = current_user.microposts.build
      #we're showing the posts from other users to,12 at a time
      # @feed_items is rendered in shared_feed.html.erb
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 12)
    end
  end

  def about
  end

  def contact
  end
end