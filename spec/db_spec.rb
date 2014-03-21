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
    expect(new_link).to be_a(OVOST::Link)
    expect(new_link.destination_url).to eq("http://twitter.com")
    expect(new_link.short_id).to eq("kf12oj")
  end

  xit "stores created links in hash indexed by short_id" do

  end

  xit "can create a new User" do

  end

  xit "can create a new link with user" do

  end

end
