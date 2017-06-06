require 'test_helper'

class CoordinateValidatorTest < MySQLPoint::TestCase
  class Model
    include ActiveModel::Validations

    attr_reader :location

    def initialize(location)
      @location = location
    end

    validates :location, coordinate: true
  end

  test 'valid values' do
    [
      [-180, -90],
      [0, 0],
      [180, 90]
    ].each do |val|
      coord = MySQLPoint::Coordinate.new(longitude: val[0], latitude: val[1])
      assert Model.new(coord).valid?, val
    end
  end

  test 'invalid values' do
    [
      [-181, -91],
      [nil, nil],
      [181, 91]
    ].each do |val|
      coord = MySQLPoint::Coordinate.new(longitude: val[0], latitude: val[1])
      refute Model.new(coord).valid?, val
    end
  end
end
