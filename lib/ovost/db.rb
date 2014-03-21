class OVOST::Database

  def intialize
    @link_count = 0
  end

  def gen_id
    @link_count += 1
    (@link_count - 1).to_s(36)
  end
end
