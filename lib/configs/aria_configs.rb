module Aria
  # Aria enter page
  ARIA_HOST = ENV["aria_host"] || "https://admintools.future.stage.ariasystems.net"
  # Default password for all password field
  DEFAULT_PWD = "test1234"

  WORK_IFRAME = %w( outerFrame mainFrame work_frm )
  INNER_WORK_IFRAME = %w( outerFrame mainFrame work_frm inner_work_frm )
end
