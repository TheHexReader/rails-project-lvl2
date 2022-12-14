# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

require 'minitest'
require 'minitest/autorun'
require 'minitest/power_assert'

module ActiveSupport
  # TestCase class
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    include Devise::Test::IntegrationHelpers
    include Warden::Test::Helpers

    # Add more helper methods to be used by all tests here...
    def log_in(user)
      if integration_test?
        login_as(user, scope: :user)
      else
        sign_in(user)
      end
    end
  end
end
