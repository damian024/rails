require 'test_helper'
require 'generators/flat/flat_generator'

class FlatGeneratorTest < Rails::Generators::TestCase
  tests FlatGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
