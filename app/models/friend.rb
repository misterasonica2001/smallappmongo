class Friend
	include MongoMapper::Document
	safe
	
	key :follower_id, ObjectId
	key :followed_id, ObjectId
	timestamps!
	
	ensure_index :follower_id
	ensure_index :followed_id
	
	attr_accessible :followed_id
	
	belongs_to :follower, :class_name => "User"
	belongs_to :followed, :class_name => "User"
	
	validates_presence_of :follower_id, :followed_id
	
end
