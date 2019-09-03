require "bundler/setup"
require "boxing/kata/boxing_kata"
require "boxing/kata/box_scheduler"
require "boxing/kata/family"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# Boxing Scheduler Class Tests
RSpec.describe BoxScheduler do
  before :all do
    @scheduler = BoxScheduler.new
  end

  it 'creates a BoxScheduler class' do
    expect(@scheduler).to be_kind_of(BoxScheduler)
  end

  it 'scheduler has load family preferences function' do
    expect(@scheduler).to respond_to(:load_family_preferences)
  end

end

# Family Class Tests
RSpec.describe Family do
  before :all do
    @starWarsFamily = Family.new
  end

  it 'creates a Family class' do
    expect(@starWarsFamily).to be_kind_of(Family)
  end
end