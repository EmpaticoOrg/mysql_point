require_relative 'type'

module MySQLPoint::TypeMap
  private def initialize_type_map(m)
    super.tap do
      m.register_type(/^point/, MySQLPoint::Type.new)
    end
  end
end
