class OVOST::Terminal
  def initialize(database)
    @database = database
    @control = []
  end

  def menu
    puts "Here are your options:"
    puts ""
    puts "Inputs in CAPS, optional inputs in (parentheses)"
    puts ""
    puts "user create EMAIL PASSWORD (ADMIN? true/false) - Create a new user"
    puts "user list - List all users"
    puts "user links USER_ID - List all links for a user"
    puts ""
    puts "link create URL (USER_ID) - Create a new link"
    puts "link list - List all links"
    puts "link clicks LINK_ID - Show all clicks for a link"
    puts ""
    puts "click LINK_ID - Click a link"
    puts ""
    puts "help - Show menu again"
    puts "quit - Quit"

    input

    while @control[0] != "quit" do
      case @control[0]
        when "help" then menu
        when "user"
          case @control[1]
            when "create" then create_user
            when "list" then list_users
            when "links" then list_user_links
            else input
          end
        when "link"
          case @control[1]
            when "create" then create_link
            when "list" then list_links
            when "clicks" then list_link_clicks
            else input
          end
        when "click" then click
        else input
      end
    end
  end

  def input
    puts "Enter your choice:"
    @control = gets.chomp.downcase.split
  end

  def create_user
    if @control[4] == "true"
      user = @database.create_user(@control[2], @control[3], true)
      puts "Admin created with ID: #{user.user_id} Email: #{@control[2]}"
    else
      user = @database.create_user(@control[2], @control[3])
      puts "User created with ID: #{user.user_id} Email: #{@control[2]}"
    end
    input
  end

  def list_users
    puts "ID:\tEmail:\t\t\t\tAdmin:"
    @database.users.each do |user_id, user|
      print "#{user_id}\t#{user.email}\t\t\t"
      if user.is_admin
        puts "X"
      else
        puts ""
      end
    end
    input
  end

  def list_user_links
    puts "Link ID:\tDestination URL:"
    @database.get_users_links(@control[2].to_i).each do |link|
      puts "#{link.link_id}\t\t#{link.destination_url}"
    end
    input
  end

  def create_link
    if @control[3]
      link = @database.create_link(@control[2], @control[3].to_i)
      puts "User #{link.user_id} created link with ID: #{link.link_id} Destination URL: #{link.destination_url}"
    else
      link = @database.create_link(@control[2])
      puts "Link created with ID: #{link.link_id} Destination URL: #{link.destination_url}"
    end
    input
  end

  def list_links
    puts "Link ID:\tUser ID:\tDestination URL:"
    @database.links.each do |link_id, link|
      puts "#{link_id}\t\t#{link.user_id}\t\t#{link.destination_url}"
    end
    input
  end

  def list_link_clicks
    puts "Click ID:\tClick Time:"
    @database.get_links_clicks(@control[2]).each do |click|
      puts "#{click.click_id}\t\t#{click.time}"
    end
    input
  end

  def click
    puts @database.click_link(@control[1])
    input
  end
end
