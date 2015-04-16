clmoduleass Validator
  def successfull_registration
    fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Your account has been activated. You can now log in.'
  end

  def checking_flash_for_pswd
    fail 'Test is failed' unless @browser.find_element(id: 'flash_notice').text == 'Password was successfully updated.'
  end
end