require 'digest'

class Micropost
	include MongoMapper::Document
	safe
	
	MAX_CHARS = 140
	
	key :content, String
	key :user_id, ObjectId, :index => true
	timestamps!
	
	
	attr_accessible :content
	
	belongs_to :user
	
	validates_presence_of :user_id, :content
	validates_length_of :content, :maximum => MAX_CHARS
	
	#scope :latest, sort(:created_at.desc)
	
	def self.from_friends_of_user(user)
		micros = Array.new()
		user.friends.each do |f_id|
			micro_user = User.find_by_id(f_id.followed_id)
			micro = micro_user.microposts
			if !micro.nil? 
				micro_a = Array(micro)
				micro_a.each do |f_id_s|
					micros << f_id_s
					end
			end	
		end
		mine = user.microposts
		micros.concat(Array(mine))	
		micros.sort!{|a, b| b.created_at <=> a.created_at}
		return micros
	end

end