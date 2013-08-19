module Bus
  module DataObj
    # This class contains attributes for add new role
    class Role
      attr_accessor :type, :name, :parent

      def initialize(type = nil, name = nil, parent = nil)
        first_name = Forgery::Name.first_name
        last_name = Forgery::Name.last_name
        @name = name || "AA #{first_name} #{last_name}"
        @parent = parent || 'Root' # default value for 'Root'
        @type = type || "Mozy, Inc. admin" # default value for 'Mozy, Inc. admin'
      end
    end
  end
end
