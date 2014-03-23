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
    input
  end

  def list_users
    input
  end

  def list_user_links
    input
  end

  def create_link
    input
  end

  def list_links
    input
  end

  def list_link_clicks
    input
  end

  def click
    input
  end
end
