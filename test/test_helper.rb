$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mysql_point'

require 'minitest/autorun'

class MySQLPoint::TestCase < Minitest::Test
  def self.test(str, &block)
    name = 'test_' + str.gsub(/[^a-z_]/, '_').gsub(/_{2,}/, '_')
    define_method name, &block
  end
end
