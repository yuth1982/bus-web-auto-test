
# Browser time out in seconds
DEFAULT_WAIT_TIME = (ENV["timeout"] || 120).to_i

# Files downloaded location
DOWNLOAD_FOLDER = "downloads"

SCREEN_SHOT = (ENV["screen_shot"] || "no").eql?("yes")

# Print out time stamp in steps
TIMESTAMP = (ENV["timestamp"] || "no").eql?("yes")

DELETE_TEST_PARTNER = (ENV["delete_test_partner"] || "no").eql?("yes")