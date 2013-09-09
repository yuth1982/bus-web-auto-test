def set_timezone(timezone)
  Time.zone = timezone
  Chronic.time_class = Time.zone
end

def with_timezone(timezone)
  pre_timezone = ActiveSupport::TimeZone[Time.now.utc_offset / 3600]
  set_timezone(timezone)
  yield
ensure
  set_timezone(pre_timezone)
end
