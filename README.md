# Capistrano::Backup

Invoke Backup Task via Capistrano.

## Installation

### In your Gemfile:

Add this line to your application's Gemfile:

```ruby
gem 'backup-tasks', git: "git@github.com:semabit/backup-tasks.git"
gem 'capistrano-backup', git: "git@github.com:semabit/capistrano-backup.git"
```

The gem `backup-tasks` is a dependency which provides the rake tasks.

And then execute:

    $ bundle

### In your Capfile:

Now you need to require the backup tasks in your Capfile.  
Put this line after any of capistrano's own require/load statements (specifically load 'deploy' for Cap v2):
```ruby
require "capistrano/backup"
```


## Usage

```ruby
cap <env> create_backup
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shanehofstetter/capistrano-backup.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
