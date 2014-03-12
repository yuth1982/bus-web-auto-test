require 'pg'
require File.expand_path('../../test_sites/configs/configs_helper', __FILE__)
@host = QA_ENV['db_host']
@port = QA_ENV['db_port']
@db_user = QA_ENV['db_user']
@db_name = QA_ENV['db_name']

def delete_user_by_email(email)
  begin
    conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
    sql = "UPDATE users SET deleted = 't', deleted_time = now(), userhash = null WHERE username = '#{email}';"
    c = conn.exec sql
    c.check
    puts sql
    if c.cmd_tuples >= 1
      puts "#{email} is updated successfully"
    else
      puts "Nothing updated for #{email}"
    end
  rescue PGError => e
    puts 'postgres error'
  ensure
    conn.close unless conn.nil?
  end
end

def delete_users_by_email(email)
  begin
    conn = PG::Connection.open(:host => @host, :port=> @port, :user => @db_user, :dbname => @db_name)
    sql = "UPDATE users SET deleted = 't', deleted_time = now(), userhash = null WHERE username like '#{email}';"
    c = conn.exec sql
    c.check
    puts sql
    if c.cmd_tuples >= 1
      puts "#{email} is updated successfully"
    else
      puts "Nothing updated for #{email}"
    end
  rescue PGError => e
    puts 'postgres error'
  ensure
    conn.close unless conn.nil?
  end
end

%w(test110836@test.com fediduser1@test.com dev-17538-test1@test.com dev-17538-test2@test.com dev-17538-test3@test.com).each do |email|
  delete_user_by_email(email)
end

delete_users_by_email('%17544-test%@test.com')
delete_users_by_email('%17542-test%@test.com')
