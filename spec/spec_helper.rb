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
    @starWarsFamily = Family.new
  end

  it 'creates a BoxScheduler class' do
    expect(@scheduler).to be_kind_of(BoxScheduler)
  end

  it 'Ship starter box responds correctly when not provided preferences' do
    expect(@scheduler.ship_starter_box(@starWarsFamily)).to eq("NO STARTER BOXES GENERATED\n")
  end

  it 'Ship starter box responds with correct starter boxes based on family preferences' do
    @preferences = 'spec/fixtures/family_preferences.csv'
    @starWarsFamily.load_family_preferences(@preferences)

    expect(@scheduler.ship_starter_box(@starWarsFamily)).to eq(
        "STARTER BOX\n" +
        "2 blue brushes\n" +
        "2 blue replacement heads\n" +
        "\n" +
        "STARTER BOX\n" +
        "2 green brushes\n" +
        "2 green replacement heads\n" +
        "\n" +
        "STARTER BOX\n" +
        "1 pink brush\n" +
        "1 pink replacement head\n")
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
    @preferences = 'spec/fixtures/family_preferences.csv'
    @starWarsFamily.load_family_preferences(@preferences)
  end

  it 'creates a Family class' do
    expect(@starWarsFamily).to be_kind_of(Family)
  end

  it 'load_family_preferences takes a csv file and reads user preferences' do
    expect(@starWarsFamily.get_family_data).to contain_exactly( ['2', 'Anakin', 'blue', nil, '2018-01-01'],
                                            ['3', 'Padme', 'pink', '2', nil],
                                            ['4', 'Luke', 'blue', '2', nil],
                                            ['5', 'Leia', 'green', '2', nil],
                                            ['6', 'Ben', 'green', '2', nil])
  end

  it 'contract effective date is set correctly from the configuration file' do
    expect(@starWarsFamily.get_contract_effective_date()).to eq('2018-01-01')
  end

  it 'primary insured id is set correctly from the configuration file' do
    expect(@starWarsFamily.get_primary_insured_id()).to eq('2')
  end

  it 'get brush preferences returns the correct brush preferences' do
    expect(@starWarsFamily.get_brush_preferences).to contain_exactly( ['blue', 2], ['green', 2], ['pink', 1])
  end

end