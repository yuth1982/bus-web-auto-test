
# Browser time out in seconds
DEFAULT_WAIT_TIME = (ENV['TIMEOUT'] || 120).to_i

# Files downloaded location
DOWNLOAD_FOLDER = 'downloads'

SCREEN_SHOT = (ENV['SCREEN_SHOT'] || 'no').eql?('yes')

# Print out time stamp in steps
TIMESTAMP = (ENV['TIMESTAMP'] || 'no').eql?('yes')

DELETE_TEST_PARTNER = (ENV['DELETE_TEST_PARTNER'] || 'no').eql?('yes')

# ATF uses br env variable to decide which browser will launch
# available browser: firefox, chrome, ie, webkit
BROWSER = (ENV['br'] || 'firefox').downcase