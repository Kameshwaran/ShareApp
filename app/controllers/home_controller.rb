class HomeController < ApplicationController
	def index
		@user = User.find(current_user.id) if user_signed_in?
		@items = Item.all
	end
end
