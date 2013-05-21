require 'pg'
module DBHelper
  @host = BUS_ENV['db_host']
  @port = BUS_ENV['db_port']
  @db_user = BUS_ENV['db_user']
  @db_name = BUS_ENV['db_name']

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
      Log.debug sql
      Log.debug @host
      Log.debug @port
      Log.debug @db_user
      Log.debug @db_name
      c = conn.exec(sql)
      c.values[0][0]
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

  def get_user_email
    begin
      conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
      sql = "select username from public.users limit 1;"
      c = conn.exec(sql)
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
      sql = "select username from public.admins limit 1;"
      c = conn.exec(sql)
      c.values[0][0]
    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end
  end
end