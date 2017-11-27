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
# cap <env> create_backup
# example:
cap production create_backup
```
