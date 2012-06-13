module Bus
  class AddNewPromoView < PageObject

  element :description_tb, {:id => "promotion_description"}
  element :promo_code_tb, {:id => "promotion_code"}

  element :promo_value_tb, {:id => "promotion_promo_value"}

  element :valid_from_tb, {:id => "promotion_effective_date"}
  element :valid_to_tb, {:id => "promotion_expiration_date"}

  element :usage_limit_tb, {:id => "promotion_times"}

  element :valid_on_renewal_true_rb, {:id => "promotion_valid_on_renewal_true"}
  element :valid_on_renewal_false_rb, {:id => "promotion_valid_on_renewal_false"}

  element :save_btn, {:xpath => "//div[@id='promotion-new-content']//input[@id='commit']"}

  element :promo_created_txt, {:xpath => "//div[@id='promotion-new-errors']/ul[@class='flash successes']"}

  def add_new_account promo_obj
    description_tb.type_text promo_obj.description
    promo_code_tb.type_text promo_obj.promo_code

    promo_value_tb.type_text promo_obj.discount_value

    valid_from_tb.type_text promo_obj.valid_from
    valid_to_tb.type_text promo_obj.valid_to

    usage_limit_tb.type_text promo_obj.usage_limit

    promo_obj.valid_on_renewal ? valid_on_renewal_true_rb.click : valid_on_renewal_false_rb.click

    save_btn.click
  end

end
end