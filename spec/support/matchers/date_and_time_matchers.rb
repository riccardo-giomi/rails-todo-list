# frozen_string_literal: true

RSpec::Matchers.define :be_the_same_datetime do |expected|
  match do |actual|
    actual.to_datetime.in_time_zone == expected.to_datetime.in_time_zone
  end
end

RSpec::Matchers.define :be_the_same_date do |expected|
  match do |actual|
    actual.to_date == expected.to_date
  end
end

RSpec::Matchers.define :be_the_same_time do |expected|
  match do |actual|
    # To correcly emulate DB time fields (which hold no info on the date), Rails
    # will set the day of a :time field to 2000-01-01. We need to do the same to
    # compare, in addition to casting and setting the local timezone.
    really_expected = Time.zone.parse(expected).change(year: 2000, month: 1, day: 1)
    actual.to_time.in_time_zone == really_expected
  end
end
