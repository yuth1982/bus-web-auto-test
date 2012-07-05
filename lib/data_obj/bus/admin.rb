module Bus
  class Admin
    attr_accessor :user_name, :name, :password

    def initialize(user_name,name,password)
      @user_name = user_name
      @name = name
      @password = password
    end
  end
end