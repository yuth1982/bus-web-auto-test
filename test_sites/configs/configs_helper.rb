require 'yaml'

# Load all env settings from env.yaml
ALL_ENV = YAML.load_file("#{File.dirname(__FILE__)}/env.yaml")

CONFIGS = YAML.load_file("#{File.dirname(__FILE__)}/configs.yaml")

# used for localized links, etc
LANG = YAML.load_file("#{File.dirname(__FILE__)}/lang.yaml")

# Active QA test environment, for example qa5, qa6
TEST_ENV = ENV['BUS_ENV'] || 'qa12h'
QA_ENV = ALL_ENV[TEST_ENV]

# Active aria test environment, for example aria qa
ARIA_ENV = ALL_ENV[ENV['ARIA_ENV'] || 'aria_qa']

# Active aria api test environment, for example aria api qa
case TEST_ENV
  when /qa*/
    ARIA_API_ENV = ALL_ENV[ENV['ARIA_API_ENV'] || 'aria_api_qa']
    # Active AD connection test environment, for example ad_connection_qa
    AD_CONNECTION_ENV = ALL_ENV[ENV['AD_CONNECTION_ENV'] || 'ad_connection_qa']
  when /std*/
    ARIA_API_ENV = ALL_ENV[ENV['ARIA_API_ENV'] || 'aria_api_std']
    AD_CONNECTION_ENV = ALL_ENV[ENV['AD_CONNECTION_ENV'] || 'ad_connection_prod']
  when /pantheon*/
    ARIA_API_ENV = ALL_ENV[ENV['ARIA_API_ENV'] || 'aria_api_pantheon']
    AD_CONNECTION_ENV = ALL_ENV[ENV['AD_CONNECTION_ENV'] || 'ad_connection_prod']
  when /prod*/
    ARIA_API_ENV = ALL_ENV[ENV['ARIA_API_ENV'] || 'aria_api_production']
    AD_CONNECTION_ENV = ALL_ENV[ENV['AD_CONNECTION_ENV'] || 'ad_connection_prod']
end

# ATF uses br env variable to decide which browser will launch
# available browser: firefox, chrome, ie, webkit
BROWSER = (ENV['br'] || 'firefox').downcase

SCREEN_SHOT = (ENV["SCREEN_SHOT"] || "no").eql?("yes")
