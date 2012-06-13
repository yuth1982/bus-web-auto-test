module Aria
  class PlanMapping
    attr_accessor :master_plan_id, :desk_licence_id, :server_licence_id, :desk_quota_id, :server_quota_id

    def initialize(master_plan_id, desk_licence_id, server_licence_id, desk_quota_id, server_quota_id)
      @master_plan_id = master_plan_id
      @desk_licence_id = desk_licence_id
      @server_licence_id = server_licence_id
      @desk_quota_id =desk_quota_id
      @server_quota_id = server_quota_id
    end
  end
end