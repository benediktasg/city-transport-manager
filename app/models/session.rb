class Session
  @user, @role=nil, :none

  class << self
    attr_reader :user, :role
  
    def login(username, password)
      user=User.find_by(username: username, password: password)
      raise 'incorrect_login' if user.nil?
      @user, @role=user, user.role
    end
    
    def logout
      raise 'incorrect_logout' if (@user.nil? or @role==:none)
      @user,@role=nil,:none
    end
    
  end
end
