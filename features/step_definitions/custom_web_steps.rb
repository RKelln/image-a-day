def find_fields(locator)
  all(:xpath, XPath.field(locator))
end

Then /^some "([^"]*)" field(?: within "([^"]*)")? should contain "([^"]*)"$/ do |field, selector, value|
  found = false
  with_scope(selector) do
    find_fields(field).each do |field|
      field_value = (field.tag_name == 'textarea') ? field.text : field.value
      if field_value =~ /#{value}/
        found = true
        break
      end
    end
  end
  
  assert found
end

Then /^no "([^"]*)" field(?: within "([^"]*)")? should contain "([^"]*)"$/ do |field, selector, value|
  found = false
  with_scope(selector) do
    find_fields(field).each do |field|
      field_value = (field.tag_name == 'textarea') ? field.text : field.value
      if field_value =~ /#{value}/
        found = true
        break
      end
    end
  end
  
  assert !found
end

Given /^today is "([^\"]*)"$/ do |date|
  Timecop.freeze(Date.parse(date))
end

Then /^(?:|I )should see the date "([^"]*)"(?: within "([^"]*)")?$/ do |date, selector|
  date = Date.parse(date)
  found = false
  with_scope(selector) do
    found |= page.has_content?(short_date(date))
    found |= page.has_content?(long_date(date))
  end
  
  assert found
end

Then /^(?:|I )should not see the date "([^"]*)"(?: within "([^"]*)")?$/ do |date, selector|
  date = Date.parse(date)
  found = false
  with_scope(selector) do
    found |= page.has_content?(short_date(date))
    found |= page.has_content?(long_date(date))
  end
  
  assert !found
end

When /^(?:|I )follow \/([^\/]*)\/(?: within "([^"]*)")?$/ do |link_regexp, selector|
  regexp = Regexp.new(link_regexp)
  with_scope(selector) do
    find('a', :text => regexp).click
  end
end
