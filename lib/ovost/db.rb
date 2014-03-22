class OVOST::Database

  attr_reader :links, :users

  def initialize
    @links_created = 0
    @users_created = 0
    @links = {}
    @users = {}

  end

  def gen_id
    @links_created.to_s(36)
  end

  def create_link(url, user=nil)
       # binding.pry
    @links_created += 1
    @links[gen_id] = OVOST::Link.new(url, user)
  end

  def create_user(email, password, is_admin=false)
    @users_created += 1
    @users[@users_created] = OVOST::User.new(email, password, is_admin)
  end
end
