# BeerClient

Ruby API client for BeER service.

## Installation

Install the gem and add to the application's Gemfile by executing:

```sh
$ bundle add beer --git "git@github.com:begateway/beer_client.git"
```

or add to Gemfile manually

```
gem 'beer', git: 'git@github.com:begateway/beer_client.git'
```

## Usage

### Initialization client

``` ruby
client = Beer::Client.new(
  password: 'YOUR BEER ADMIN KEY',
  url: 'YOUR BEER HOST NAME'
)
```

### Headers

You can set headers for client, for example:

``` ruby
client = Beer::Client.new(
  password: 'YOUR BEER ADMIN KEY',
  url: 'YOUR BEER HOST NAME',
  options: {headers: {'X-Request-Id' => '123334455'}}
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/begateway/beer_client.
