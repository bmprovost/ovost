class OVOST::Database

  # attr_reader :links_created

  def initialize
    @links_created = 0
  end


  def gen_id
    @links_created.to_s(36)
  end
end
