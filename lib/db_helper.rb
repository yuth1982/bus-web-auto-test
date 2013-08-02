require 'pg'
module DBHelper
  @host = QA_ENV['db_host']
  @port = QA_ENV['db_port']
  @db_user = QA_ENV['db_user']
  @db_name = QA_ENV['db_name']

  # Public: change user's last sync at time to days's before by user_id
  #
  def change_last_sync_at(user_id, days)
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      t = (Time.now - (days + 1) * 24 * 3600)
      sql = "update user_sync_details set last_sync_at='#{t}' where user_id=#{user_id};"
      c = conn.exec(sql)
    rescue PGError => e
      puts 'postgres error'
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
    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end
  end

  def update_machine_info(machine_id, quota, time = 'now()')
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "UPDATE machines SET space_used = #{quota}::bigint*1024*1024*1024 , pending_space_used = 0, patches = 0, files = 1, last_client_version = null,last_backup_at = #{time}, last_successful_backup_at = #{time} WHERE id = #{machine_id};;"
      c = conn.exec(sql)
    rescue PGError => e
      puts 'postgres error'
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
    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_user_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from public.users where username like '%@decho.com%' and deleted = false and creation_time IS NOT NULL order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PGError => e
      puts 'postgres error'
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
    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end

  end

  def get_admin_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from public.admins where username like '%@decho.com%' and deleted_at IS NULL order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_mh_user_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from public.users where username like '%@decho.com%' and deleted = false and user_group_id = 4151 order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_suspended_user_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from public.users where (username like '%@decho.com%' or username like '%redacted-%') and deleted = false and suspended_at NOTNULL order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end
  end

  def get_deleted_user_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from public.users where username like '%@decho.com%' and deleted = true order by id DESC limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PGError => e
      puts 'postgres error'
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
        sql = "insert into machines(alias, machine, user_id, site, sync, created_at, updated_at) values ('AUTOTEST', 'machinehash#{Time.now.to_i}', #{user_id}, 'qa6', false, now(), now());"
        conn.exec sql
        Log.debug sql

        sql = "select id from machines order by id desc limit 1"
        c = conn.exec sql
        Log.debug sql
        machine_id = c.values[0][0].to_i

        sql = "update mozy_pro_keys set machine_id = #{machine_id}, activated_at = now() where id = #{mozy_pro_key_id}";
        conn.exec sql
        Log.debug sql

        sql = "update machines set space_used = #{quota}::bigint*1024*1024*1024, pending_space_used = 1024, patches = 0, files = 1, last_client_version = null,last_backup_at = now() where id = #{machine_id};"
        conn.exec sql
        Log.debug sql

        sql = "insert into machine_storage_pools(owner_id, license_type_id, created_at, updated_at) values(#{machine_id}, #{license_type_id}, now(), now());"
        conn.exec sql
        Log.debug sql
      end
    rescue PGError
      puts 'postgres error'
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
    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end
  end
end
