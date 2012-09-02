
class Capybara::Session

  # Public: Execute multiline script
  #
  # Example:
  #  page.execute_multiline_script(%{
  #   var changeEvent=document.createEvent('HTMLEvents');
  #   changeEvent.initEvent('change', false, true);
  #   document.getElementById('#{discount_tb.id}').dispatchEvent(changeEvent);
  #  })
  #
  # Returns nothing
  def execute_multiline_script(javascript)
    execute_script("(function(){ #{javascript} })()")
  end

  #
  #
  #
  # Returns the result
  def evaluate_multiline_script(javascript)
    evaluate_script("(function(){ #{javascript} })()")
  end

  def suppress_alert(accept=true)
    execute_script("window.confirm = function() { return #{accept}; }")
  end


  def trigger_html_event(element_id, event_name)
    evaluate_multiline_script(%{
      var event = document.createEvent('HTMLEvents');
      event.initEvent('#{event_name}', false, true);
      document.getElementById('#{element_id}').dispatchEvent(event);
      return;
    })


  end

end