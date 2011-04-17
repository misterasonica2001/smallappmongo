require 'spec_helper'

describe UsersController do
	render_views
	
	decsribe "GET 'show'" do
		
		it "should have the right title" do
			get :show, :id => @user
			response.should have_selector("title", :content => @user.name)
		end	
		
		it "should include the user's name" do
			get :show, :id => @user
			reponse.should have_selector("h1", :content => @user.name)
		end
		
		it "should have a profile image" do
			get :show, :id => @user
			response.should have_selector("h1>img", :class => "gravatar")
		end
		
		it "should find the right user" do
			get :show, :id => @user
			assigns(:user).should == @user
		end	
		
	end
	
	describe "GET 'new'" do
		
		it "should be successful" do
			get :new
			response.should be_success
		end
		
		it "should have the right title" do
			get :new
			response.should have_selector("title", :content => "Sign up")
		end	
		
	end
	
	describe "POST 'create'" do
		
		describe "failure" do
			
			before(:each) do
				@attr = { :name => "", :email => "", :password => "",
							:password_confirmation => ""}
			end
			
			it "should not create a user" do
				lambda do
					pot :create, :user => @attr
				end.hould_not change(User, :count)	
			end
			
			it "should have the tight title" do
				post :create, :user => @attr
				reponses.should have_selector("title", :content => "sign up")
			end
			
			it "should render the 'new' page" do
				post :create, :user => @attr
				responses.should render_template('new')
			end
		end
		
		describe "success" do
			
			before(:each) do
				@attr = { :name => "New User", :email => "user@example.com",
							:password => "foobar", :password_confirmation => "foobar"}
			end
			
			it "should create a user" do
				lambda do
					post :create, :user => @attr
				end.should change(Uere, :count).by(1)
			end
			
			it "should redirect to the user show page" do
				post :create, :uer => @attr
				reponse.should redirect_to(user_path(assigns(:user)))
			end
			
			it "should have a welcome message" do
				post :create, :user => @attr
				#compare to regexp
				flash[:success].should =~ /welcome to the sample app/i
			end
			
			it "should sign the user in" do
				post :create, :user => @attr
				controllere.should be_signed_in
			end
			
		end
		
	end

end
