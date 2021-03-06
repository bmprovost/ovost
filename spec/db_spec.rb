require 'spec_helper'

describe "Database" do
  before do
    # OVOST::Database.instance = OVOST::Database.instance.new
    @url = "twitter.com"
    OVOST::Database.instance.instance_variable_set("@links_created", 1234567890)
    OVOST::Database.instance.instance_variable_set("@users_created", 0)
    OVOST::Database.instance.instance_variable_set("@clicks", {})
  end

  it "can generate a short_id" do
    expect(OVOST::Database.instance.gen_link_id).to eq("kf12oi")
  end

  it "can create a new Link with no user" do
    new_link = OVOST::Database.instance.create_link(@url)
    expect(new_link.destination_url).to eq("http://twitter.com")
    expect(new_link.link_id).to eq("kf12oj")
  end

  it "stores created links in hash indexed by short_id" do
    new_link = OVOST::Database.instance.create_link(@url)
    expect(OVOST::Database.instance.links["kf12oj"]).to be_a(OVOST::Link)
  end

  it "can create a new User" do
    new_user = OVOST::Database.instance.create_user('fake@email.com', 'password')
    expect(new_user).to be_a(OVOST::User)
  end

  it "stores users in hash" do
    new_user = OVOST::Database.instance.create_user('fake@email.com', 'password')
    expect(OVOST::Database.instance.users[1]).to be_a(OVOST::User)
  end

  it "can create a new link with user" do
    new_user = OVOST::Database.instance.create_user('fake@email.com', 'password')
    new_link = OVOST::Database.instance.create_link('twitter.com', new_user.user_id)

    expect(OVOST::Database.instance.links["kf12oj"].user_id).to be_a(Integer)
  end

  it "stores a hash of {user_id: x, link_id: y} in an array if the link has a user" do    OVOST::Database.instance.instance_variable_set("@join_users_links", [])
    new_user = OVOST::Database.instance.create_user('fake@email.com', 'password')
    new_link = OVOST::Database.instance.create_link('twitter.com', new_user.user_id)
    expect(OVOST::Database.instance.join_users_links[0]).to eq({user_id: 1, link_id: "kf12oj"})
  end

  it "can get all links created by user" do
    new_user = OVOST::Database.instance.create_user('fake@email.com', 'password')
    id = new_user.user_id
    OVOST::Database.instance.create_link('twitter.com', id)
    OVOST::Database.instance.create_link('google.com', id)
    OVOST::Database.instance.create_link('geocities.com', id)
    OVOST::Database.instance.create_link('anotherone', id)

    all_links = OVOST::Database.instance.get_users_links(id)

    expect(all_links).to be_a(Array)
    expect(all_links.size).to eq(4)
    expect(all_links[3]).to be_a(OVOST::Link)
  end

  it "clicks link with given link_id and returns destination_url" do
    new_link = OVOST::Database.instance.create_link(@url)
    link_id = new_link.link_id
    expect(OVOST::Database.instance.click_link(link_id)).to eq("http://twitter.com")
  end

  it "adds new Click to clicks hash when link is clicked" do
    new_link = OVOST::Database.instance.create_link(@url)
    link_id = new_link.link_id
    OVOST::Database.instance.click_link(link_id)
    expect(OVOST::Database.instance.clicks[1]).to be_a(OVOST::Click)
    expect(OVOST::Database.instance.clicks[1].time).to be_a(Time)
    expect(OVOST::Database.instance.clicks[1].link_id).to eq(link_id)
  end

  it "stores a hash of {link_id: x, click_id: y} in an array when link is clicked" do
    new_link = OVOST::Database.instance.create_link(@url)
    link_id = new_link.link_id
    OVOST::Database.instance.click_link(link_id)
    expect(OVOST::Database.instance.join_links_clicks[0]).to eq({link_id: "kf12oj", click_id: 1})
  end

  it "can get all clicks for a link" do
    new_link = OVOST::Database.instance.create_link(@url)
    link_id = new_link.link_id
    5.times { OVOST::Database.instance.click_link(link_id) }
    all_clicks = OVOST::Database.instance.get_links_clicks(link_id)
    expect(all_clicks).to be_a(Array)
    expect(all_clicks.count).to eq(5)
    expect(all_clicks[2]).to be_a(OVOST::Click)
  end

  it "create_link does not push to @join_users_links if user_id is not an existing user" do
    OVOST::Database.instance.create_link("google.com",500)
    expect(OVOST::Database.instance.users).to eq({})
    expect(OVOST::Database.instance.links["kf12oj"].destination_url).to eq("http://google.com")
  end

  it "click_link returns http://ovo.st but does not create new clicks if link_id is not an existing link" do
    bad_link = OVOST::Database.instance.click_link("idontexist")
    expect(bad_link).to eq("http://ovo.st")
    expect(OVOST::Database.instance.clicks).to eq({})
  end
end
