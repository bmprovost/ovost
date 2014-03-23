require 'spec_helper'

describe "Database" do
  before do
    @db = OVOST::Database.new
    @url = "twitter.com"
    @db.instance_variable_set("@links_created", 1234567890)
    @db.instance_variable_set("@users_created", 0)
    @db.instance_variable_set("@clicks", {})
  end

  it "can generate a short_id" do
    expect(@db.gen_link_id).to eq("kf12oi")
  end

  it "can create a new Link with no user" do
    new_link = @db.create_link(@url)
    expect(new_link.destination_url).to eq("http://twitter.com")
    expect(new_link.link_id).to eq("kf12oj")
  end

  it "stores created links in hash indexed by short_id" do
    new_link = @db.create_link(@url)
    expect(@db.links["kf12oj"]).to be_a(OVOST::Link)
  end

  it "can create a new User" do
    new_user = @db.create_user('fake@email.com', 'password')
    expect(new_user).to be_a(OVOST::User)
  end

  it "stores users in hash" do
    new_user = @db.create_user('fake@email.com', 'password')
    expect(@db.users[1]).to be_a(OVOST::User)
  end

  it "can create a new link with user" do
    new_user = @db.create_user('fake@email.com', 'password')
    new_link = @db.create_link('twitter.com', new_user.user_id)

    expect(@db.links["kf12oj"].user_id).to be_a(Integer)
  end

  it "stores a hash of {user_id: x, link_id: y} in an array if the link has a user" do    @db.instance_variable_set("@join_users_links", [])
    new_user = @db.create_user('fake@email.com', 'password')
    new_link = @db.create_link('twitter.com', new_user.user_id)
    expect(@db.join_users_links[0]).to eq({user_id: 1, link_id: "kf12oj"})
  end

  it "can get all links created by user" do
    new_user = @db.create_user('fake@email.com', 'password')
    id = new_user.user_id
    @db.create_link('twitter.com', id)
    @db.create_link('google.com', id)
    @db.create_link('geocities.com', id)
    @db.create_link('anotherone', id)

    all_links = @db.get_users_links(id)

    expect(all_links).to be_a(Array)
    expect(all_links.size).to eq(4)
    expect(all_links[3]).to be_a(OVOST::Link)
  end

  it "clicks link with given link_id and returns destination_url" do
    new_link = @db.create_link(@url)
    link_id = new_link.link_id
    expect(@db.click_link(link_id)).to eq("http://twitter.com")
  end

  it "adds new Click to clicks hash when link is clicked" do
    new_link = @db.create_link(@url)
    link_id = new_link.link_id
    @db.click_link(link_id)
    expect(@db.clicks[1]).to be_a(OVOST::Click)
    expect(@db.clicks[1].time).to be_a(Time)
    expect(@db.clicks[1].link_id).to eq(link_id)
  end

  it "stores a hash of {link_id: x, click_id: y} in an array when link is clicked" do
new_link = @db.create_link(@url)
    link_id = new_link.link_id
    @db.click_link(link_id)
    expect(@db.join_links_clicks[0]).to eq({link_id: "kf12oj", click_id: 1})
  end

  it "can get all clicks for a link" do
    new_link = @db.create_link(@url)
    link_id = new_link.link_id
    5.times { @db.click_link(link_id) }
    all_clicks = @db.get_links_clicks(link_id)
    expect(all_clicks).to be_a(Array)
    expect(all_clicks.count).to eq(5)
    expect(all_clicks[2]).to be_a(OVOST::Click)
  end
end
