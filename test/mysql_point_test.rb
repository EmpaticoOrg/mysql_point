require 'test_helper'

class MySQLPointTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MySQLPoint::VERSION
  end
end
