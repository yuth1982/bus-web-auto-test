module Freyja
  module DataObj
    # This class contains attributes for data shuttle order
    class Restore
      attr_accessor :restore_name, :incl_deleted, :restore_date, :restore_format, :num_files, :track_num, :partner_id, :machine_id, :restore_id, :use_company_info, :dvd_to_biz

      # Public: Initialize the Restore object
      #
      def initialize
        super
        @restore_name = "TestRestore-#{Time.now.strftime("%Y%m%d-%H%M%S")}"
        @track_num = "#{Time.now.strftime("%YD%m%dR%H%M%SCC")}"
        @incl_deleted = false
        @restore_date = "#{Time.now.strftime("%m/%d/%Y")}"
        @restore_format = ""
        @num_files = ""
        @partner_id = ""
        @machine_id = ""
        @restore_id = ""
        @use_company_info = true
        @dvd_to_biz = true
      end

      # Public: output mozy home attributes
      #
      # Returns mozy home formatted attributes text
      def to_s
        %{#{super}
        restore_name: #@restore_name
        track_num: #@track_num
        incl_deleted: #@incl_deleted
        restore_date: #@restore_date
        restore_format: #@restore_format
        num_files: #@num_files
        partner_id: #@partner_id
        machine_id: #@machine_id
        restore_id: #@restore_id
        use_company_info: #@use_company_info
        dvd_to_biz: #@dvd_to_biz}
      end


    end
  end
end
