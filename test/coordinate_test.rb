require 'test_helper'

class MySQLPoint::CoordinateTest < MySQLPoint::TestCase
  A_WKB = "\x01\x01\x00\x00\x00q=\n\xD7\xA3\xB0(@\x0E-\xB2\x9D\xEF'\e\xC0"
  A_WKB.force_encoding(Encoding::ASCII_8BIT)

  test '.from_wkt with valid wkt' do
    point = MySQLPoint::Coordinate.from_wkt('POINT(12.345 -6.789)')
    assert_equal 12.345, point.longitude
    assert_equal(-6.789, point.latitude)
  end

  test '.from_wkt with unknown value' do
    ['HAX(12 56)', 'POINT(12.345)', 'POINT(12 34 56)', 'POINT(12, 34)'].each do |val|
      assert_nil MySQLPoint::Coordinate.from_wkt(val)
    end
  end

  test '.from_wkb with valid wkb' do
    point = MySQLPoint::Coordinate.from_wkb(A_WKB)

    assert_equal 12.345, point.longitude
    assert_equal(-6.789, point.latitude)
  end

  test '.from_wkb with invalid wkb' do
    point = MySQLPoint::Coordinate.from_wkb('not a WKB')
    assert_nil point
  end

  test '#initialize' do
    p = MySQLPoint::Coordinate.new(longitude: 1, latitude: 2)
    assert_equal Float, p.longitude.class

    p = MySQLPoint::Coordinate.new(longitude: nil, latitude: nil)
    assert_nil p.longitude
  end

  test '#to_wkt' do
    p = MySQLPoint::Coordinate.new(longitude: 12.345, latitude: -6.789)
    assert_equal 'POINT(12.3450000 -6.7890000)', p.to_wkt
  end

  test '#to_wkb' do
    p = MySQLPoint::Coordinate.new(longitude: 12.345, latitude: -6.789)
    assert_equal A_WKB.bytes, p.to_wkb.bytes
  end
end
