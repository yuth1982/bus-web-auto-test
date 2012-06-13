module Bus
  class Admin
    attr_accessor :id, :user_name, :name, :password

    def initialize(id,user_name,name,password)
      @id = id
      @user_name = user_name
      @name = name
      @password = password
    end
  end
end