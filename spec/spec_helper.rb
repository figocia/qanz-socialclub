# This file was generated by the `rails generate rspec:install` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause this
# file to always be loaded, without a need to explicitly require it in any files.
#
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, make a
# separate helper file that requires this one and then use it only in the specs
# that actually need it.
#
# The `.rspec` file also contains a few flags that are not defaults but that
# users commonly want.
#
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

RSpec.configure do |config|
  config.before(:all) do 
    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
    "New York, NY", [
      {
        'latitude'     => 40.7143528,
        'longitude'    => -74.0059731,
        'address'      => 'New York, NY, USA',
        'state'        => 'New York',
        'state_code'   => 'NY', 
        'country'      => 'United States',
        'country_code' => 'US'
      }
     ]
    )
  end
end
