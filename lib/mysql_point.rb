require 'active_record'

module MySQLPoint
end

require_relative 'mysql_point/version'
require_relative 'mysql_point/coordinate'
require_relative 'coordinate_validator'

# enables column type in ActiveRecord
require 'active_record/connection_adapters/mysql2_adapter'
require_relative 'mysql_point/type_map'
ActiveRecord::ConnectionAdapters::Mysql2Adapter.prepend MySQLPoint::TypeMap

# enables a Coordinate to be sent as WKT and converted by a MySQL function on insert/update
require_relative 'mysql_point/quoting'
ActiveRecord::ConnectionAdapters::Mysql2Adapter.prepend MySQLPoint::Quoting

# enables shorthand syntax in migrations and db/schema.rb
require_relative 'mysql_point/column_method'
ActiveRecord::ConnectionAdapters::MySQL::TableDefinition.include MySQLPoint::ColumnMethod
ActiveRecord::ConnectionAdapters::MySQL::Table.include MySQLPoint::ColumnMethod

# enables schema dumping into migration syntax
ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter::NATIVE_DATABASE_TYPES[:point] = {
  name: 'point'
}
