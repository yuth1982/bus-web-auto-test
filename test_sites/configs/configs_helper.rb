require 'yaml'

# Load all env settings from env.yaml
ALL_ENV = YAML.load_file("#{File.dirname(__FILE__)}/env.yaml")

CONFIGS = YAML.load_file("#{File.dirname(__FILE__)}/configs.yaml")

# used for localized links, etc
LANG = YAML.load_file("#{File.dirname(__FILE__)}/lang.yaml")

# Active QA test environment, for example qa5, qa6
QA_ENV = ALL_ENV[ENV['BUS_ENV'] || 'qa13']

# Active aria test environment, for example aria qa
ARIA_ENV = ALL_ENV[ENV['ARIA_ENV'] || 'aria_qa']

# Active aria api test environment, for example aria api qa
ARIA_API_ENV = ALL_ENV[ENV['ARIA_API_ENV'] || 'aria_api_qa']

# Active zimbra mail
ZIMBRA_ENV = ALL_ENV['zimbra']

# ATF uses br env variable to decide which browser will launch
# available browser: firefox, chrome, ie, webkit
BROWSER = (ENV['br'] || 'firefox').downcase

SCREEN_SHOT = (ENV["SCREEN_SHOT"] || "no").eql?("yes")
