require 'minitest/autorun'
require 'active_record'

# establish the database connection
ActiveRecord::Base.establish_connection(
  ENV['DATABASE_URL'] || 'mysql2://root@localhost/mysql_point_test'
)
ActiveRecord::Migration.verbose = false

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mysql_point'

class MySQLPoint::TestCase < Minitest::Test
  def self.test(str, &block)
    name = 'test_' + str.gsub(/[^a-z_]/, '_').gsub(/_{2,}/, '_')
    define_method name, &block
  end
end
