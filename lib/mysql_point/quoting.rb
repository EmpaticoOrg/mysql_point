module MySQLPoint::Quoting
  def quote(value)
    if value.respond_to?(:to_wkt)
      "ST_GeomFromText(#{super(value.to_wkt)})"
    else
      super
    end
  end
end
