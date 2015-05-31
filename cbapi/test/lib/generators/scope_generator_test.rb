require 'test_helper'
require 'generators/scope/scope_generator'

class ScopeGeneratorTest < Rails::Generators::TestCase
  tests ScopeGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
