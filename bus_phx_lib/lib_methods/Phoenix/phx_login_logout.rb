
def phx_navigate_to_signup
  @phoenix_site = PhoenixSite.new
  @phoenix_site.select_dom.load
end