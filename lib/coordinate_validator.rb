class CoordinateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.respond_to?(:latitude) &&
              (-90..90).cover?(value.latitude) &&
              value.respond_to?(:longitude) &&
              (-180..180).cover?(value.longitude)

    record.errors.add(attribute, options[:message] || :invalid)
  end
end
