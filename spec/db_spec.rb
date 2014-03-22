require 'spec_helper'

describe "Database" do
  before do
    @db = OVOST::Database.new
    @url = "twitter.com"
  end

  it "can generate a short_id" do
    @db.instance_variable_set("@links_created", 1234567890)
    expect(@db.gen_id).to eq("kf12oi")
  end

  it "contains a hash of links" do
    expect(@db.links).to be_a(Hash)
  end

  it "can create a new Link with no user" do
    @db.instance_variable_set("@links_created", 1234567890)
    new_link = @db.create_link(@url)
    expect(new_link.destination_url).to eq("http://twitter.com")
    # expect(new_link.short_id).to eq("kf12oj")
  end

  it "stores created links in hash indexed by short_id" do
    @db.instance_variable_set("@links_created", 1234567890)
    new_link = @db.create_link(@url)
    expect(@db.links["kf12oj"]).to be_a(OVOST::Link)
  end

  it "can create a new User" do
    new_user = @db.create_user('fake@email.com', 'password')
    expect(new_user).to be_a(OVOST::User)
  end

  it "stores users in hash" do
    @db.instance_variable_set("@users_created", 0)
    new_user = @db.create_user('fake@email.com', 'password')
    expect(@db.users[1]).to be_a(OVOST::User)
  end

  it "can create a new link with user" do
    @db.instance_variable_set("@users_created", 0)
    @db.instance_variable_set("@links_created", 1234567890)
    new_user = @db.create_user('fake@email.com', 'password')
    new_link = @db.create_link('twitter.com', new_user)

    expect(@db.links["kf12oj"].user.email).to eq('fake@email.com')
  end
end
