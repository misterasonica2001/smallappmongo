require 'digest'
#require 'active_model'

class User
	include MongoMapper::Document
	safe
	#include ActiveModel::Validations
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	set_database_name = "smallmongo"
	
	key :name, String
	key :email, String
	key :password, String	
	key :salt, String
	key :encrypted_password, String
	key :admin, Boolean, :default => false
	timestamps!

	validates_presence_of :name, :email, :password, :password_confirmation
	validates_uniqueness_of :email, :case_sensitive => false 
	validates_uniqueness_of :name, :case_sensitive => false 
	validates_format_of :email, :with =>email_regex
	validates_length_of :name, :maximum => 50
	validates_length_of :password, :within => 6..40
	validates_confirmation_of :password
	
	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation
	
	has_many :microposts, :dependent => :destroy
	has_many :friends, :foreign_key => "follower_id",
							:dependent => :destroy
	#has_many :following, :through => :relationships, :source => :followed
	#has_many :reverse_relationships, :foreign_key => "followed_id",
	#								:class_name => "Relationship",
	#								:dependent => :destroy
	#has_many :followers, :through => :reverse_relationships, 
	#								:source => :follower
	
	before_save :encrypt_password
	#before_save :convert_user
	
	def feed
		# This is preliminary. See Chapter 12 for the full implementation.
		#Micropost.where(:user_id => BSON::ObjectId("4dbd27037fac1a132c000001")).all
		#Micropost.find_by_user_id(id)
		Micropost.from_friends_of_user(self)
	end
	
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end
	
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end	
	
	def self.authenticate_with_salt(id, cookie_salt)
		user = find(id)
		(user && user.salt == cookie_salt) ? user : nil
	end
	
	def is_friend?(followed)
		friends.find_by_followed_id(followed.id)
	end
	
	def befriend!(to_befriend, current_user_id)
		friends.create!(:followed_id => to_befriend.id)
		to_befriend.friends.create!(:followed_id => current_user_id)
	end
	
	def unfriend!(to_unfriend, current_user_id)
		friends.find_by_followed_id(to_unfriend.id).destroy
		to_unfriend.friends.find_by_followed_id(current_user_id).destroy
	end
	
	
	private
			#def convert_user
			#	self.user.map!{|m| m.to_mongo}
			#end
			
			def encrypt_password
				self.salt = make_salt if new_record?
				self.encrypted_password = encrypt(password)
			end
			
			def encrypt(string)
				secure_hash("#{salt}--#{string}")
			end
			
			def make_salt
				secure_hash("#{Time.now.utc}--#{password}")
			end
			
			def secure_hash(string)
				Digest::SHA2.hexdigest(string)
			end
end
