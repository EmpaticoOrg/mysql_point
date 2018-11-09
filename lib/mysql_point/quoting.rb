module MySQLPoint::Quoting
  def quote(value)
    # ActiveRecord 5.0, 5.1
    if value.respond_to?(:to_wkt)
      "ST_GeomFromText(#{super(value.to_wkt)})"
    # ActiveRecord 5.2
    elsif value.respond_to?(:value_for_database) && value.value_for_database.respond_to?(:to_wkt)
      "ST_GeomFromText(#{super(value.value_for_database.to_wkt)})"
    else
      super
    end
  end
end
