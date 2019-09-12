require "boxing/kata/version"
require "boxing/kata/box_scheduler"
require "boxing/kata/family"
require 'csv'

module Boxing
  module Kata

    def self.report
      unless has_input_file?
        puts "Usage: ruby ./bin/boxing-kata <spec/fixtures/family_preferences.csv"
      end
      
      cmd_line = STDIN.gets
      cmd_line = "spec/fixtures/family_preferences.csv"
      scheduler = BoxScheduler.new
      starWarsFamily = Family.new
      print starWarsFamily.load_family_preferences(cmd_line)
      print scheduler.ship_starter_box(starWarsFamily)
      print scheduler.ship_refill_boxes(starWarsFamily)
    end

    def self.has_input_file?
      !STDIN.tty?
    end
  end
end
