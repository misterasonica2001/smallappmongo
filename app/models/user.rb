require 'digest'
#require 'active_model'

class User
	include MongoMapper::Document
	safe
	#include ActiveModel::Validations
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	key :name, String
	key :email, String
	key :password, String	
	key :salt, String
	key :encrypted_password, String
	timestamps!

	validates_presence_of :name, :email, :password, :password_confirmation
	validates_uniqueness_of :email, :case_sensitive => false 
	validates_uniqueness_of :name, :case_sensitive => false 
	validates_format_of :email, :with =>email_regex
	validates_length_of :name, :maximum => 50
	validates_length_of :password, :within => 6..40
	validates_confirmation_of :password
	
	attr_accessible :name, :email, :password, :password_confirmation
	
	before_save :encrypt_password
	
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
	
	private
		
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
