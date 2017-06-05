# MySQLPoint

Provides basic ActiveRecord support for MySQL `point` fields. This becomes useful in MySQL 5.7.6, which adds [`ST_DISTANCE_SPHERE`](https://dev.mysql.com/doc/refman/5.7/en/spatial-convenience-functions.html#function_st-distance-sphere) for practical distance-between-points-on-Earth calculations.

## Features

Included:

* migrations
* schema dumping and loading
* reading and writing from database
* providing a Ruby struct
* providing an ActiveModel validator

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

TODO:

* migration example
* setting as struct
* setting as string
* validating
* using ST_DISTANCE_SPHERE in MySQL

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mysql_point. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the MySQLPoint project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/mysql_point/blob/master/CODE_OF_CONDUCT.md).
