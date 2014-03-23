class OVOST::User
  attr_reader :email, :user_id, :is_admin

  def initialize(email, password, user_id, is_admin=false)
    @email = email
    @password = password
    @user_id = user_id
    @is_admin = is_admin
  end
end
