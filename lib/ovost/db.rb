class OVOST::Database

  attr_reader :links, :users, :users_links

  def initialize
    @links_created = 0
    @users_created = 0
    @links = {}
    @users = {}
    @users_links = []
  end

  def gen_id
    @links_created.to_s(36)
  end

  def create_link(url, user=nil)
       # binding.pry
    @links_created += 1
    @links[gen_id] = OVOST::Link.new(url, user)
    @users_links.push({user_id: user.id, link_id: gen_id}) if user
    @links[gen_id]
  end

  def create_user(email, password, is_admin=false)
    @users_created += 1
    @users[@users_created] = OVOST::User.new(email, password, @users_created, is_admin)
  end

  def get_users_links(user) #Should this take a user or an id?

  end
end
