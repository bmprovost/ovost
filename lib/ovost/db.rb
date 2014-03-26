require 'singleton'

class OVOST::Database
  include Singleton

  attr_reader :links, :users, :clicks, :join_users_links, :join_links_clicks

  def initialize
    @links_created = 0
    @users_created = 0
    @total_clicks = 0
    @links = {}
    @users = {}
    @clicks = {}
    @join_users_links = []
    @join_links_clicks = []
  end

  def gen_link_id
    @links_created.to_s(36)
  end

  def create_link(url, user_id=nil)
    @links_created += 1
    @links[gen_link_id] = OVOST::Link.new(gen_link_id, url, user_id)
    @join_users_links.push({user_id: user_id, link_id: gen_link_id}) if @users.has_key?(user_id)
    @links[gen_link_id]
  end

  def create_user(email, password, is_admin=false)
    @users_created += 1
    @users[@users_created] = OVOST::User.new(email, password, @users_created, is_admin)
    @users[@users_created]
  end

  def get_users_links(user_id)
    @join_users_links.select do |hash|
      hash[:user_id] == user_id
    end.map do |hash|
      @links[hash[:link_id]]
    end
  end

  def click_link(link_id)
    if @links.has_key?(link_id)
      @total_clicks += 1
      @clicks[@total_clicks] = OVOST::Click.new(@total_clicks, link_id)
      @join_links_clicks.push({link_id: link_id, click_id: @total_clicks})
      return @links[link_id].destination_url
    else
      return "http://ovo.st"
    end
  end

  def get_links_clicks(link_id)
    @join_links_clicks.select do |hash|
      hash[:link_id] = link_id
    end.map do |hash|
      @clicks[hash[:click_id]]
    end
  end
end
