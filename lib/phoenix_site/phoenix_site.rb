class PhoenixSite
  def select_dom
    Phoenix::DomSelection.new
  end

  def admin_fill_out
    Phoenix::AddNewPhoenixPartner.new
  end

  def partner_fill_out
    Phoenix::NewPartnerFillout.new
  end

  def licensing_fill_out
    Phoenix::NewPartnerLicensingFillout.new
  end

  def billing_fill_out
    Phoenix::NewPartnerBillingFillout.new
  end

  def reg_complete_pg
    Phoenix::NewRegistrationComplete.new
  end

  # stub for account verification
  #def acct_verify
    #Phoenix::AccountVerification.new
  #end
end