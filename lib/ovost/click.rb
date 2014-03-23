class OVOST::Click
  attr_reader :link_id, :time

  def initialize(link_id)
    @link_id = link_id
    @time = Time.now
  end
end
