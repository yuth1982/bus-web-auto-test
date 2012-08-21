
# Browser time out in seconds
BROWSER_IMPLICIT_WAIT = (ENV["timeout"] || 240).to_i

# Files downloaded location
DOWNLOAD_FOLDER = "download"

SCREEN_SHOT = (ENV["screen_shot"] || "no").eql?("yes")

# Print out time stamp in steps
TIMESTAMP = (ENV["timestamp"] || "no").eql?("yes")

DELETE_TEST_PARTNER = (ENV["delete_test_partner"] || "no").eql?("yes")