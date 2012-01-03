def have_setting_content(setting, expectation)
  page.send(expectation, have_content(setting.key))
  page.send(expectation, have_content(setting.value))
end
