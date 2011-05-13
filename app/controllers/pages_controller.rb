class PagesController < ApplicationController
  def home
	@title = "Acasa"
	if signed_in?
		@micropost = Micropost.new
		@feed_items = current_user.feed.paginate(:page => params[:page])
	end
  end

  def contact
	@title = "Contact"
  end

  def about
	@title = "Despre"
  end
  
  def help
	@title = "Ajutor"
	end
end
