class FriendsController < ApplicationController
	before_filter :authenticate

	def create
		@user = User.find_by_id(params[:friend][:followed_id])
		current_user.befriend!(@user, current_user.id)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
			end
	end

	def destroy
		@followed_id = Friend.find(params[:id]).followed_id
		@user = User.find_by_id(@followed_id)
		current_user.unfriend!(@user, current_user.id)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end
end