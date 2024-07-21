class HomeController < ApplicationController
  def index
    return unless logged_in?

    @micropost = current_user.microposts.build
    @pagy, @feed_items = pagy current_user.feed, items: Settings.page_items
  end
end
