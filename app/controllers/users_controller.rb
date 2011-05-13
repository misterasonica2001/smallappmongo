class UsersController < ApplicationController
	before_filter :authenticate, :except => [:show, :new, :create]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user, :only => :destroy
	
	def new
		@title = "Inscriere"
		@user = User.new
	end
  
	def index
		@title = "Toti utilizatorii"
		@users = User.paginate(:page => params[:page])
	end
  
	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.sort(:created_at.desc).paginate(:page => params[:page])
		@title = @user.name
	end	
	
	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Bine ai venit in comunitate!"
			redirect_to @user
		else
			@title = "Inscriere"
			@user.password = ""
			@user.password_confirmation = ""
			render 'new'
		end
	end
	
	def edit
		#@user = User.find(params[:id])
		@title = "Personalizare"
	end

	def update
		#@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profil modificat cu succes."
			redirect_to @user
		else
			@title = "Personalizare"
			render 'edit'
		end
	end
	
	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "Utilizatorul a fost sters."
		redirect_to users_path
	end
	
	def friends
		@title = "Prieteni"
		@user = User.find(params[:id])
		@user_friends = @user.friends.paginate(:page => params[:page])
		@users_all = Array.new()
		@user_friends.each do |item| 
			@f = User.find(item[:followed_id])
			@users_all << @f
			end
		@users = @users_all.paginate(:page => params[:page])
		render 'show_friends'
	end
	
	private
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
		
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end
