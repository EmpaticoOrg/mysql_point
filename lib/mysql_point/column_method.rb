module MySQLPoint::ColumnMethod
  def point(*args, **options)
    args.each{|name| column(name, :point, options) }
  end
end
