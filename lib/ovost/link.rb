class OVOST::Link
  attr_reader :destination_url, :user_id, :link_id

  def initialize(link_id, destination_url, user_id=nil)
    @link_id = link_id
    @user_id = user_id

    if (destination_url.length < 5)
      @destination_url = "http://ovo.st"
    elsif destination_url[0..6].downcase == "http://" || destination_url[0..7].downcase == "https://"
      @destination_url = destination_url
    else @destination_url = "http://#{destination_url}"
    end
  end
end
