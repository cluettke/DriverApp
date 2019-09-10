require 'date'

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

  it 'scheduler\'s compute refill dates returns dates every 90 days after effective date' do
    refill_dates = Array.new
    effective_date = Date.new(2019, 1, 1)
    refill_dates = @scheduler.compute_refill_dates( effective_date )
    expect(refill_dates).to contain_exactly(Date.new(2019, 4, 1), Date.new(2019, 6, 30),
                                            Date.new(2019, 9, 28), Date.new(2019, 12, 27))
  end

  it 'scheduler\'s compute refill dates returns dates every 90 days after 2019-08-01 for 1 year' do
    refill_dates = Array.new
    effective_date = Date.new(2019, 8, 1)
    refill_dates = @scheduler.compute_refill_dates( effective_date )
    expect(refill_dates).to contain_exactly(Date.new(2019, 10, 30), Date.new(2020, 1, 28),
                                            Date.new(2020, 4, 27), Date.new(2020, 7, 26))
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

  it 'load_family_preferences takes a csv file and reads user preferences' do
    preferences = 'spec/fixtures/family_preferences.csv'
    family_data = @starWarsFamily.load_family_preferences(preferences)
    family_data = @starWarsFamily.get_family_data()
    expect(family_data).to contain_exactly( ['2', 'Anakin', 'blue', nil, '2018-01-01'],
                                            ['3', 'Padme', 'pink', '2', nil],
                                            ['4', 'Luke', 'blue', '2', nil],
                                            ['5', 'Leia', 'green', '2', nil],
                                            ['6', 'Ben', 'green', '2', nil])
  end

 
end