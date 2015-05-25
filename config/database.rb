# Use the database as set, used by heroku
# Fal back to database based on rack enviroment
DATABASE_URL = ENV.fetch('DATABASE_URL'){
  "postgres://localhost/scorched_blog_#{RACK_ENV}"
}

Sequel::Model.plugin(:schema)
DB = Sequel.connect(DATABASE_URL)
DB.extension(:pagination)
