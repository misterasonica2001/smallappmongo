#MongoMapper.connection = Mongo::Connection.new('localhost', 27017)#MongoMapper.database = "#smallmongo-#{Rails.env}"#User.ensure_index(:email)#if defined?(PhusionPassenger)#   PhusionPassenger.on_event(:starting_worker_process) do |forked|#     MongoMapper.connection.connect if forked#   end#end#mongodb://heroku::561ff2hidrv715jbqxnokj@flame.mongohq.com:27023/app504120#MongoMapper.connection = Mongo::Connection.new(ENV['DB_HOST'], ENV["DB_PORT"]).db(ENV['DB_DATABASE'])#MongoMapper.database.authenticate(ENV["MONGO_USER"], ENV["MONGO_PASSWORD"])ENV['DATABASE_URL'] = 'mongodb://cosmin.loony@flame.mongohq.com:27098/smallmongo'ENV['MONGOHQ_URL'] = 'mongodb://cosmin.loony@flame.mongohq.com:27098/smallmongo'MongoMapper.connection = Mongo::Connection.new('flame.mongohq.com', 27098, { :logger => Rails.logger })MongoMapper.database = 'smallmongo'MongoMapper.database.authenticate('cosmin', 'loony')if ENV['MONGOHQ_URL'] #MongoMapper.config = {RAILS_ENV => {'uri' => ENV['MONGOHQ_URL']}} #MongoMapper.connection = Mongo::Connection.new(ENV['DB_HOST'], ENV['DB_PORT']).db("smallmongo")	#set_database_name = "smallmongo"	#connection Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])	#MongoMapper.connection = Mongo::Connection.new(ENV['DB_HOST'], ENV['DB_PORT'])   # MongoMapper.database = ENV['DB_NAME']   # MongoMapper.database.authenticate(ENV['DB_USER'], ENV['DB_PASS']) else # MongoMapper.config = {RAILS_ENV => {'uri' => 'mongodb://localhost/sushi'}}end#MongoMapper.database = "smallmongo"#MongoMapper.connect(RAILS_ENV)