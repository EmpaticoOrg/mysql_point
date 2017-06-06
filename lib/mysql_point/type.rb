class MySQLPoint::Type < ActiveModel::Type::Value
  # for schema dumping
  def type
    :point
  end

  # from ruby type (Coordinate) to quotable database value (Coordinate)
  # this depends on the MySQLPoint::Quoting mixin to work.
  def serialize(value)
    value
  end

  # from database value (WKB, Coordinate) to ruby value (Coordinate)
  def deserialize(value)
    if value.respond_to?(:to_wkt)
      value
    elsif value
      MySQLPoint::Coordinate.from_wkb(value[4..-1])
    end
  end

  # from attribute setter (WKT, Coordinate) to ruby value (Coordinate)
  # and from user input (WKT) to ruby value (Coordinate)
  def cast(value)
    if value.respond_to?(:to_wkt)
      value
    elsif value
      MySQLPoint::Coordinate.from_wkt(value)
    end
  end
end
