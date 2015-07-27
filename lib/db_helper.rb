require 'pg'
module DBHelper
  @host = QA_ENV['db_host']
  @port = QA_ENV['db_port']
  @db_user = QA_ENV['db_user']
  @db_name = QA_ENV['db_name']

  # Public: verify home user by user_name
  #
  def change_email_verified_at(username)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      t = (Time.now)
      Log.debug "########Time.now is #{Time.now}"
      Log.debug "########t is #{t}"
      Log.debug "########username is #{username}"
      sql = "update users set email_verified_at='#{t}' where username='#{username}';"
      c = conn.exec(sql)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  # Public: change user's last sync at time to days's before by user_id
  #
  def change_last_sync_at(user_id, days)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      t = (Time.now - (days + 10) * 24 * 3600)
      Log.debug "########Time.now is #{Time.now}"
      Log.debug "########t is #{t}"
      Log.debug "########user_id is #{user_id}"
      sql = "update user_sync_details set last_sync_at='#{t}' where user_id='#{user_id}';"
      c = conn.exec(sql)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_machine_id_by_license_key(license_key)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select machine_id from mozy_pro_keys where keystring ='#{license_key}';"
      c = conn.exec(sql)
      c.values[0][0].to_i
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def update_machine_info(machine_id, quota, time = 'now()')
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE machines SET space_used = #{quota}::bigint*1024*1024*1024 , pending_space_used = 0, patches = 0, files = 1, last_client_version = null,last_backup_at = #{time}, last_successful_backup_at = #{time} WHERE id = #{machine_id};;"
      c = conn.exec(sql)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def machine_available_quota(machine_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select machine_available_quota(#{machine_id});"
      c = conn.exec(sql)
      c.values[0][0].to_i/(1024 ** 3)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_user_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from public.users where username like '%@decho.com%' and deleted = false and creation_time IS NOT NULL and username not in (select username from public.admins where username like '%@decho.com%' and deleted_at IS NULL) order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_user_username(parent)
    partner_id = case parent
                              when 'ME'
                                "mozy_enterprise_partner_id"
                              when 'MC'
                                "mozy_corp_partner_id"
                              when 'MP'
                                "mozy_pro_partner_id"
                              when 'MH'
                                "mozy_consumer_partner_id"
                              when 'MEO'
                                "mozy_enterprise_old_partner_id"
                              else
                               puts "Parent partner code entered (#{parent}) is not supported"
                            end
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from users u where u.user_group_id in (
              select ug.id as ug_id from user_groups ug where ug.pro_partner_id in (
                select id from pro_partners sub_pt, (
                  select tree_sortkey from pro_partners p where p.id in (
                    select cast(value as integer) from global_settings where key = '#{partner_id}')) as key
              where sub_pt.tree_sortkey between key.tree_sortkey and tree_right(key.tree_sortkey)))
            and u.enforce_unique_username = true and u.userhash is not null and u.username is not null and u.creation_time is not null and deleted = false limit 1;"
      c = conn.exec(sql)
      Log.debug("Email from tree #{parent} = #{c.values[0][0]}")
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end

  end

  def get_admin_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from public.admins where username like '%@gmail.com%' and deleted_at IS NULL and passwordhash IS NOT NULL and username not in (select username from users where username like '%@gmail.com%' and deleted = false) order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_mh_user_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from users where username like '%@decho.com%' and deleted = false and user_group_id = 4151 order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_suspended_user_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from public.users where (username like '%@decho.com%' or username like '%redacted-%') and deleted = false and suspended_at NOTNULL and username not in (select username from users where username like '%@decho.com%' and deleted = false) order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_deleted_user_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from users u1 where username SIMILAR TO '%@(gmail|emc).com%' and deleted = true and not exists (select 1 from users u2 where u2.deleted = false and u1.username = u2.username) order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def create_machines(user_id, license_name, count, quota)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select license_types.id from license_types where
                license_types.name = '#{license_name}' and
                license_types.pro_partner_id = (select pro_partners.parent_pro_partner_id from pro_partners where
                  pro_partners.id = (select user_groups.pro_partner_id from user_groups where
                    user_groups.id = (select users.user_group_id from users where
                      users.id = #{user_id} limit 1)
                  limit 1)
                limit 1)
              limit 1;"
      c = conn.exec sql
      Log.debug sql
      license_type_id = c.values[0][0].to_i

      sql = "select id from mozy_pro_keys where
              activated_at is null and
              user_group_id = (select user_group_id from users where users.id = #{user_id} limit 1) and
              license_type_id = #{license_type_id}
            limit #{count};"
      mozy_pro_key_ids = conn.exec(sql).values.map(&:first)
      Log.debug sql
      mozy_pro_key_ids.each_with_index do |mozy_pro_key_id, index|
        Log.debug "#{index} / #{mozy_pro_key_ids.size}"
        sql = "insert into machines(alias, machine, user_id, site, sync, created_at, updated_at) values ('AUTOTEST', 'machinehash#{Time.now.to_i+index}', #{user_id}, '#{QA_ENV['data_center']}', false, now(), now());"
        conn.exec sql
        Log.debug sql

        sql = "select id from machines where user_id = #{user_id} order by id desc limit 1"
        c = conn.exec sql
        Log.debug sql
        machine_id = c.values[0][0].to_i

        sql = "update machines set space_used = #{quota}::bigint*1024*1024*1024, pending_space_used = 1024, patches = 0, files = 1, last_client_version = null,last_backup_at = now() where id = #{machine_id};"
        conn.exec sql
        Log.debug sql

        sql = "insert into machine_storage_pools(owner_id, license_type_id, created_at, updated_at) values(#{machine_id}, #{license_type_id}, now(), now());"
        conn.exec sql
        Log.debug sql

        sql = "update mozy_pro_keys set machine_id = #{machine_id}, activated_at = now() where id = #{mozy_pro_key_id}";
        conn.exec sql
        Log.debug sql
      end
    rescue PG::Error => e
      puts "postgres error: #{e}"
      puts "#{$!}\n#{$@.join("\n")}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_user_id_by_email(email)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select id from users where username = '#{email}' limit 1;"
      c = conn.exec sql
      c.values[0][0].to_i
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_db_password_config(partner_id, type='user')
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select * from password_policies where pro_partner_id = #{partner_id} and (user_type = '#{type}' or user_type = 'all');"
      puts sql
      c = conn.exec sql
      if c.num_tuples.zero?
        #0 db record searched out
        nil
      else
        c[0]
      end
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_password_character_classes(password_policy_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select character_class from password_policies_character_classes where password_policy_id = #{password_policy_id};"
      c = conn.exec sql
      c.field_values('character_class')
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def set_expiration_time(user_id,days_ago)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE subscriptions SET expiration_time='#{Date.today - days_ago.to_i} 12:12:12' WHERE user_id = #{user_id};"
      puts sql
      conn.exec sql
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  def set_backup_suspended_at(user_id,weeks_ago)

    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE users SET backup_suspended_at = '#{Date.today - (weeks_ago * 7)}' WHERE id = #{user_id};"
      conn.exec sql
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  def set_gc_notify_at(user_id,weeks_ago)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE users SET gc_notify_at = '#{Date.today - (weeks_ago * 7)}' WHERE id = #{user_id};"
      conn.exec sql
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  ## Helpers ##
  def get_gc_notify_at(user_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select gc_notify_at from users where id = #{user_id};"
      conn.exec sql
      c.values[0][0].to_i
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_user_table(user_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select * from users where id = #{user_id};"
      conn.exec sql
      c.values[0][0].to_i
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_partner_setting_value(partner_id,setting_name)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select value from pro_partner_settings where key='#{setting_name}' and pro_partner_id = #{partner_id};"
      c = conn.exec sql
      c.values[0][0].to_i
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_global_setting_value(setting_name)
    begin
      sql = "select value from global_settings where key='#{setting_name}';"
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      c = conn.exec sql
      c.values[0][0].to_i
    rescue PG::Error => e
      puts "postgres error: #{e}"
      fail e
    ensure
      conn.close unless conn.nil?
    end
  end

  def update_partner_delete_timestamp(partner_id, days)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "update pro_partner_details set value=value::timestamp - interval '#{days} days' where key='purge_requested_on' and pro_partner_id=#{partner_id};"
      c = conn.exec(sql)
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_action_audits(action,admin_id,type)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "SELECT * from action_audits where action = '#{action}' and effective_admin_id = #{admin_id} order by id desc limit 1;"
      sql = "SELECT * from action_audits where action = '#{action}' and actual_admin_id = #{admin_id} order by id desc limit 1;" if type == 'actual'
      Log.debug sql
      c = conn.exec(sql)
      [c.values[0][0],c.values[0][1],c.values[0][2], c.values[0][3],c.values[0][4], c.values[0][5]]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  #   id   | action_audit_id | column_name  | table_name | record_id |               changed_from               |                changed_to                | action |      performed_at
  # 736289 |        12839186 | passwordhash | admins     |    563261 | 9bc34549d565d9505b287de0cd20ac77be1d3f2c | 86ba9a22970c2feb2d3095f889acf4c4e42473d5 | update | 2015-08-14 20:45:55-06
  def get_model_audits(action_audit_id)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "SELECT * from model_audits where action_audit_id = #{action_audit_id} order by id desc limit 1;"
      c = conn.exec(sql)
      if c.values[0].nil?
        []
      else
        [c.values[0][0],c.values[0][1],c.values[0][2], c.values[0][3],c.values[0][4], c.values[0][5], c.values[0][6], c.values[0][7]]
      end
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_info_from_admins(username)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "SELECT * from admins where username='#{username}' order by id desc limit 1;"
      Log.debug sql
      c = conn.exec(sql)
      [c.field_values('id')[0],c.field_values('passwordhash')[0]]
    rescue PG::Error => e
      puts "postgres error: #{e}"
    ensure
      conn.close unless conn.nil?
    end
  end


end


