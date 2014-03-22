class OVOST::Database

  attr_reader :links, :links_created

  def initialize
    @links_created = 0
    @links = {}
  end

  def gen_id
    @links_created.to_s(36)
  end

  def create_link(url, user=nil)
       # binding.pry
    @links_created += 1
    @links[gen_id] = OVOST::Link.new(url, user)
  end

end
