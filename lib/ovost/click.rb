class OVOST::Click
  attr_reader :link_id, :click_id, :time

  def initialize(click_id, link_id)
    @click_id = click_id
    @link_id = link_id
    @time = Time.now
  end
end
