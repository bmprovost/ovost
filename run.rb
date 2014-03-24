require_relative 'lib/ovost.rb'

database = OVOST::Database.new
terminal = OVOST::Terminal.new(database)

database.create_user("admin@email.com", "password1", true)
database.create_user("user@fake.com", "passwordistaco")
database.create_user("coolguy@hotmail.com", "1234")
database.create_user("email@fake.com", "543")

database.create_link("twitter.com")
database.create_link("google.com")
database.create_link("yahoo.com")
database.create_link("si.com", 1)
database.create_link("twoplustwo.com", 1)
database.create_link("twitter.com", 1)
database.create_link("cnn.com", 2)

5.times { database.click_link("4") }

terminal.menu
