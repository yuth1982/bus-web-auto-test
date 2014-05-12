require 'pg'
module RestoreHelper
  @db_host = QA_ENV['db_host']
  @db_port = QA_ENV['db_port']
  @db_user = QA_ENV['db_user']
  @db_name = QA_ENV['db_restores']

  def self.get_restore_id_by_restore_name(restore_name)
    begin
      conn = PG::Connection.open(:host => @db_host, :port=> @db_port, :user => @db_user, :dbname => @db_name)
      sql = "select id from restores where name = '#{restore_name}' order by id DESC limit 1;"
      c = conn.exec sql
      c.values[0][0].to_s
    rescue PGError => e
      puts 'postgres error'
    ensure
      conn.close unless conn.nil?
    end
  end

end