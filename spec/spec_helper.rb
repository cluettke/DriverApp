require "bundler/setup"
require "boxing/kata/boxing_kata"
require "boxing/kata/box_scheduler"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# Boxing Scheduler Class Tests
RSpec.describe BoxScheduler do
  it 'creates a BoxScheduler class' do
    scheduler = BoxScheduler.new
    expect(scheduler).to be_kind_of(BoxScheduler)
  end
end