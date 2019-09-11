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
    @smithFamily = Family.new
  end

  it 'creates a BoxScheduler class' do
    expect(@scheduler).to be_kind_of(BoxScheduler)
  end

  it 'Ship starter box responds correctly when not provided preferences' do
    expect(@scheduler.ship_starter_box(@starWarsFamily)).to eq("NO STARTER BOXES GENERATED\n")
  end

  it 'Ship starter box responds with correct starter boxes based on star wars family preferences' do
    @preferences = 'spec/fixtures/family_preferences.csv'
    @starWarsFamily.load_family_preferences(@preferences)

    expect(@scheduler.ship_starter_box(@starWarsFamily)).to eq(
        "STARTER BOX\n" <<
        "2 blue brushes\n" <<
        "2 blue replacement heads\n" <<
        "Schedule: 2018-01-01\n" <<
        "STARTER BOX\n" <<
        "1 pink brush\n" <<
        "1 pink replacement head\n" <<
        "1 green brush\n" <<
        "1 green replacement head\n" <<
        "Schedule: 2018-01-01\n" <<
        "STARTER BOX\n" <<
        "1 green brush\n" <<
        "1 green replacement head\n" <<
        "Schedule: 2018-01-01\n")
  end

  it 'Ship starter box responds with correct starter boxes based on smith family preferences' do
    @preferences = 'spec/fixtures/smith_preferences.csv'
    @smithFamily.load_family_preferences(@preferences)

    expect(@scheduler.ship_starter_box(@smithFamily)).to eq(
        "STARTER BOX\n" <<
        "2 red brushes\n" <<
        "2 red replacement heads\n" <<
        "Schedule: 2020-01-01\n" <<
        "STARTER BOX\n" <<
        "1 yellow brush\n" <<
        "1 yellow replacement head\n" <<
        "1 purple brush\n" <<
        "1 purple replacement head\n" <<
        "Schedule: 2020-01-01\n")
  end

  it 'Ship refill box responds with correct refill boxes based on star wars family preferences' do
    @preferences = 'spec/fixtures/family_preferences.csv'
    @starWarsFamily.load_family_preferences(@preferences)
    @scheduler.ship_starter_box(@starWarsFamily)

    expect(@scheduler.ship_refill_boxes(@starWarsFamily)).to eq(
        "REFILL BOX\n" <<
        "2 blue replacement heads\n" <<
        "1 pink replacement head\n" <<
        "1 green replacement head\n" <<
        "Schedule: 2018-04-01, 2018-06-30, 2018-09-28, 2018-12-27\n" <<
        "REFILL BOX\n" <<
        "1 green replacement head\n" <<
        "Schedule: 2018-04-01, 2018-06-30, 2018-09-28, 2018-12-27\n")
  end

  it 'Ship refill box reports error if starter box has not been shipped yet' do
    @preferences = 'spec/fixtures/smith_preferences.csv'
    refillScheduler = BoxScheduler.new
    expect(refillScheduler.ship_refill_boxes(@smithFamily)).to eq("NO STARTER BOXES GENERATED\n" )
  end

  it 'ship_starter_box will contain the correct ship date (contract effective date)' do
    @preferences = 'spec/fixtures/smith_preferences.csv'
    @smithFamily.load_family_preferences(@preferences)

    expect(@scheduler.ship_starter_box(@smithFamily)).to eq(
        "STARTER BOX\n" <<
        "2 red brushes\n" <<
        "2 red replacement heads\n" <<
        "Schedule: 2020-01-01\n" <<
        "STARTER BOX\n" <<
        "1 yellow brush\n" <<
        "1 yellow replacement head\n" <<
        "1 purple brush\n" <<
        "1 purple replacement head\n" <<
        "Schedule: 2020-01-01\n")
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

  it 'ship_refill_boxes lists the correct schedule for refill shipments' do
    @preferences = 'spec/fixtures/family_preferences.csv'
    @starWarsFamily.load_family_preferences(@preferences)
    @scheduler.ship_starter_box(@starWarsFamily)

    expect(@scheduler.ship_refill_boxes(@starWarsFamily)).to eq(
        "REFILL BOX\n" <<
        "2 blue replacement heads\n" <<
        "1 pink replacement head\n" <<
        "1 green replacement head\n" <<
        "Schedule: 2018-04-01, 2018-06-30, 2018-09-28, 2018-12-27\n" <<
        "REFILL BOX\n" <<
        "1 green replacement head\n" <<
        "Schedule: 2018-04-01, 2018-06-30, 2018-09-28, 2018-12-27\n")
  end

  it 'box with two brushes will be shipped priority mail' do
    expect(@scheduler.calculate_shipping_method(2, 0, 0)).to eq("priority")
  end

  it 'box with 1 brush, 1 replacment head will be shipped first class' do
    expect(@scheduler.calculate_shipping_method(1, 1, 0)).to eq("first")
  end

  it 'box with nothing in it will be shipped first class (no weight)' do
    expect(@scheduler.calculate_shipping_method(0, 0, 0)).to eq("first")
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

  it 'load_family_preferences returns count of brush color perferences' do
    expect(@starWarsFamily.load_family_preferences(@preferences)).to contain_exactly( ['blue', 2], ['green', 2], ['pink', 1])
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