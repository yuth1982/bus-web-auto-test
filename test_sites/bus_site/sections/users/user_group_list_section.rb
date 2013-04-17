module Bus
  class UserGroupListSection < SiteHelper::Section
    # Private elements
    #
    element(:add_group_input, css: "input[value='Add Group']")

    # Public: Click Add Group button
    #
    # Example
    #   @bus_admin_console_page.user_group_list_section.view_add_group_section
    #
    # @return [] nothing
    def view_add_group_section
      add_group_input.click
    end

    # Public: Bundled user group list rows
    #
    # Example
    #   @bus_admin_console_page.user_group_list_section.bundled_ug_list_rows
    #   # => ["(default user group)", "false", "true", "", "0", "0"]
    #
    # @return [Array<String>]
    def bundled_ug_list_rows
      ug_table.rows_text[1..-1].each do |row|
        row[1] = row[1].eql?('-') ? 'false' : 'true'
        row[2] = row[2].eql?('-') ? 'false' : 'true'
        row.delete_at(-1) # Remove action column
      end
    end

    # Public: Itemized user group list rows
    #
    # Example
    #   @bus_admin_console_page.user_group_list_section.itemized_ug_list_rows
    #   # => ["(default user group)", "false", "Shared", "", "0", "0", "10", "Shared", "", "0", "0", "200"]
    #
    # @return [Array<String>]
    def itemized_ug_list_rows
      ug_table.rows_text[1..-1].each do |row|
        row[1] = row[1].eql?('-') ? 'false' : 'true'
        row.delete_at(-1) # Remove action column
      end
    end

    # Public: View edit user group section
    #
    # @group_name [String] user group name
    #
    # Example
    #   @bus_admin_console_page.user_group_list_section.view_user_group('(default user group)')
    #
    # @return [] nothing
    def view_user_group(group_name)
      ug_table.rows[1..-1].each do |row|
        if row[0].text == group_name
          row[-1].find(:css, 'a[onclick*=edit_storage_pool_policy]').click
          break;
        end
      end
    end

    # Public: Delete user group by group name
    #
    # @group_name [String] user group name
    #
    # Example
    #   @bus_admin_console_page.user_group_list_section.delete_user_group('Group A')
    #
    # @return [] nothing
    def delete_user_group(group_name)
      ug_table.rows[1..-1].each do |row|
        if row[0].text == group_name
          row[-1].find(:css, 'form>a').click
          break;
        end
      end
    end

    private

    # Private: User Group Table
    #
    # Example
    #   @bus_admin_console_page.user_group_list_section.ug_table
    #
    # @return [element]
    def ug_table
      wait_until_bus_section_load
      find(:css, 'table.user_group_list.dataTable')
    end
  end
end