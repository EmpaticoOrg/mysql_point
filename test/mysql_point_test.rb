require 'test_helper'

class MySQLPointTest < MySQLPoint::TestCase
  class PublicWaterFountain < ActiveRecord::Base
  end

  test 'everything' do
    # establish the database connection
    ActiveRecord::Base.establish_connection(
      ENV['DATABASE_URL'] || 'mysql2://root@localhost/mysql_point_test'
    )
    ActiveRecord::Migration.verbose = false

    ActiveRecord::Schema.define(version: 1) do
      create_table :public_water_fountains, force: true do |t|
        t.point 'location', null: false
      end
    end

    vals = {
      'WKT' => 'POINT(12.34 56.78)',
      'Struct' => MySQLPoint::Coordinate.new(longitude: 12.34, latitude: 56.78)
    }

    vals.each do |name, val|
      record = PublicWaterFountain.create(location: val)
      # NOTE: turns out that it's important to test how the getter behaves after saving, because of
      # potential type casting issues determined by what was given to the *setter*.
      assert_equal 12.34, record.location.longitude, "#{name} setter parses longitude"
      assert_equal 56.78, record.location.latitude, "#{name} setter parses latitude"
    end

    # teardown the connection
    ActiveRecord::Base.connection.disconnect!
  end
end
