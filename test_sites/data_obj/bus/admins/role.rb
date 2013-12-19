module Bus
  module DataObj
    # This class contains attributes for add new role
    class Role
      attr_accessor :type, :name, :parent

      def initialize(type = nil, name = nil, parent = nil)
        first_name = Forgery::Name.first_name
        last_name = Forgery::Name.last_name
        @name = name || "AA #{first_name} #{last_name}"
        @parent = parent
        @type = type
      end
    end
  end
end
