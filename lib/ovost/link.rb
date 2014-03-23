class OVOST::Link
  attr_reader :destination_url, :user

  def initialize(link_id, destination_url, user=nil)
    @link_id = link_id
    @user = user
    # @clicks = []

    if (destination_url.length < 5)
      @destination_url = "http://ovo.st"
    elsif destination_url[0..6].downcase == "http://" || destination_url[0..7].downcase == "https://"
      @destination_url = destination_url
    else @destination_url = "http://#{destination_url}"
    end
  end

  # def click
  #   # Reserve for IP address of click, etc.
  #   @clicks.push({time: Time.now})
  #   @destination_url
  # end

  # def click_count
  #   @clicks.count
  # end
end
