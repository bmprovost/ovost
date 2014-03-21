class OVOST::Link
  attr_reader :destination_url, :click_count

  def initialize(short_id, destination_url, user=nil)
    @short_id = short_id
    @user = user
    @click_count = 0

    if (destination_url.length < 5)
      @destination_url = "http://ovo.st"
    elsif destination_url[0..6].downcase == "http://"
      @destination_url = destination_url
    elsif destination_url[0..7].downcase == "https://"
      @destination_url = destination_url
    else @destination_url = "http://#{destination_url}"
    end
  end

  def click
    @click_count += 1
    @destination_url
  end
end
