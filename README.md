# MySQLPoint

Provides basic ActiveRecord support for MySQL `point` fields. This becomes useful in MySQL 5.7.6, which adds [`ST_DISTANCE_SPHERE`](https://dev.mysql.com/doc/refman/5.7/en/spatial-convenience-functions.html#function_st-distance-sphere) for practical distance-between-points-on-Earth calculations.

## Features

Included:

* migrations
* schema dumping and loading
* reading and writing from database
* a Ruby struct
* ActiveModel validator for Earth coordinates

Future scope:

* ARel helper to find records near a static location

Never in scope:

* full `geometry` field support in MySQL

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mysql_point'
```

## Usage

**Migrating**

```ruby
class MyMigration < ActiveRecord::Migration
  def change
    create_table :public_water_fountains do |t|
      t.point 'location', null: false
      t.timestamps
    end
  end
end
```

**Validating**

```ruby
class PublicWaterFountain
  validates :location, coordinate: true
end
```

**Setting**

```ruby
# scalar values can be passed in WKT format, with longitude in first position
PublicWaterFountain.new(location: 'POINT(-73.9635288 40.7812022)')

# structured values can be passed as a MySQLPoint::Coordinate
PublicWaterFountain.new(
  location: MySQLPoint::Coordinate(longitude: -73.9635288, latitude: 40.7812022)
)
```

**Querying**

```sql
-- all public water fountains within 5 miles of Central Park
SELECT *
FROM public_water_fountains
WHERE ST_DISTANCE_SPHERE(location, POINT(-73.9675438, 40.7828687)) * 0.000621371 < 5
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/empaticoorg/mysql_point. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the MySQLPoint project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/empaticoorg/mysql_point/blob/master/CODE_OF_CONDUCT.md).
