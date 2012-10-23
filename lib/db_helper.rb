require 'pg'
module DBHelper
  HOST = 'uberdb.qa5.mozyops.com'
  PORT = 5432
  USER = 'phoenix'
  DB_NAME = 'mozy'

  # Public: change user's last sync at time to days's before by user_id
  #
  def change_last_sync_at(user_id, days)
    begin
      conn = PG::Connection.open(:host => HOST, :port=> PORT, :user => USER, :dbname => DB_NAME)
      t = (Time.now - (days + 1) * 24 * 3600)
      sql = "update user_sync_details set last_sync_at='#{t}' where user_id=#{user_id};"
      c = conn.exec(sql)
    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end
  end
end