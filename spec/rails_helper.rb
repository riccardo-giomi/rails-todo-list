# frozen_string_literal: true

require 'debug' # might as well have this always on hand.
require 'spec_helper'
require 'active_storage_validations/matchers'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Avoids an error during scaffoling, caused by generating rspec files before the
# migration for the new model.
if Rails.env.test?
  begin
    ActiveRecord::Migration.maintain_test_schema!
  rescue ActiveRecord::PendingMigrationError => e
    abort e.to_s.strip
  end
end

RSpec.configure do |config|
  config.include ActiveStorageValidations::Matchers

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  # Clean the temporary files from ActiveStorage when done.
  config.after(:all) do
    # We really, REALLY, don't want to touch the real `/storage` directory by mistake.
    if Rails.env.test?
      # This removes directories only keeping,for example, the `.keep` file that
      # Rails puts there by default.
      FileUtils.rm_rf Dir.glob(File.join(ActiveStorage::Blob.service.root, '*/'))
    end
  end
end
