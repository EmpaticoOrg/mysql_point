# A struct for latitude/longitude coordinates, with serializers and deserializers for the standard
# WKT and WKB formats.
#
# # WKT
#
# `POINT(<longitude> <latitude>)`
#
# # WKB
#
# * byte 0: byte order (little endian is 01)
# * bytes 1-4: WKB type (point is 01)
# * bytes 5-12: X coordinate (longitude)
# * bytes 13-21: Y coordinate (latitude)
class MySQLPoint::Coordinate
  # POINT(<longitude> <latitude>)
  def self.from_wkt(str)
    md = str.match(/\APOINT\((-?[0-9.]*) (-?[0-9.]*)\)\z/)
    new(longitude: md[1], latitude: md[2]) if md
  end

  def self.from_wkb(binstr)
    type = binstr[1, 4].unpack(binstr[0] == "\x01" ? 'V' : 'N').first
    return unless type == 1

    x = binstr[5, 8].unpack('D').first
    y = binstr[13, 8].unpack('D').first

    new(longitude: x, latitude: y)
  end

  attr_reader :longitude
  attr_reader :latitude

  def initialize(longitude:, latitude:)
    @longitude = longitude.to_f if longitude
    @latitude = latitude.to_f if latitude
  end

  def to_wkt
    "POINT(#{format('%.7f', longitude)} #{format('%.7f', latitude)})"
  end

  def to_wkb
    "\x01" + [1].pack('L') + [longitude, latitude].pack('D*')
  end
end
