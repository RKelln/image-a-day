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
