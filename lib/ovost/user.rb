class OVOST::User
  def initialize(email, password, is_admin=false)
    @email = email
    @password = password
    @is_admin = is_admin
  end
end
